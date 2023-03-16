//
//  Article.swift
//  QuickNews-Storyboard
//
//  Created by Chatsopon Deepateep on 16/3/23.
//

import Foundation

struct ArticleList: Decodable {
  let articles: [Article]
}

extension ArticleList {
  static var all: Resource<ArticleList> = {
    // swiftlint:disable:next force_unwrapping
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=8bfba1b8763148feb3583622592d9115")!
    return Resource(url: url)
  }()
}

struct Article: Decodable {
  let title: String
  let description: String?
}
