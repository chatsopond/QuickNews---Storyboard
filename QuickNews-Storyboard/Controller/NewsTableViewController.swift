//
//  NewsTableViewController.swift
//  QuickNews-Storyboard
//
//  Created by Chatsopon Deepateep on 16/3/23.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
  let disposeBag = DisposeBag()
  private var articles: [Article] = []
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    populateNews()
  }
}

// MARK: - Table
extension NewsTableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
      fatalError("Can't imply ArticleTableViewCell")
    }
    cell.titleLabel.text = articles[indexPath.row].title
    cell.descriptionLabel.text = articles[indexPath.row].description
    return cell
  }
}

// MARK: - Functions
extension NewsTableViewController {
  private func populateNews() {
    URLRequest.load(resource: ArticleList.all)
      .subscribe { [weak self] articleList in
        guard let self else { return }
        guard let articleList else { return }
        self.articles = articleList.articles
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      .disposed(by: disposeBag)
  }
}
