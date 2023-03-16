//
//  URLRequest+Extension.swift
//  QuickNews-Storyboard
//
//  Created by Chatsopon Deepateep on 16/3/23.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
  let url: URL
}

extension URLRequest {
//  static func load<T>(resource: Resource<T>) -> Observable<T?> {
//    let observable = Observable
//      .from([resource.url])
//      .flatMap { url -> Observable<Data> in
//        let request = URLRequest(url: url)
//        return URLSession.shared.rx.data(request: request)
//      }
//      .map { data -> T? in
//        var result: T?
//        do {
//          result = try JSONDecoder().decode(T.self, from: data)
//        } catch {
//          print("\(#function) - error: \(error)")
//        }
//        return result
//      }
//      .asObservable()
//    return observable
//  }
  static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
    let observable = Observable
      .just(resource.url)
      .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
      }
      .map { (response, data) -> T in
        if 200..<300 ~= response.statusCode {
          return try JSONDecoder().decode(T.self, from: data)
        } else {
          throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
        }
      }
      .asObservable()
    return observable
  }
}
