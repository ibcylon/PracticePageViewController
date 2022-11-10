//
//  SubscribeViewController.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

final class SubscribeViewController: UIViewController {
  
  let mainView = SubscribeTableView()
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    
  }
  
  func bind(_ subscribes: Subscribes) {
    mainView.bind(subscribes)
  }
}
