//
//  FeedViewController.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

final class FeedViewController: UIViewController {
  
  let mainView = FeedTableView()
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    
  }
  
  func bind(_ feeds: Feeds) {
    mainView.bind(feeds)
  }
}
