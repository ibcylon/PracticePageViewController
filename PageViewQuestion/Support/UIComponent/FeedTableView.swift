//
//  CustomTableView.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit
import SnapKit

class FeedTableView: UITableView {
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: .zero, style: .insetGrouped)
    setUpLayout()
    setUpConfigure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var resource: Feeds = [] {
    didSet {
      self.reloadData()
    }
  }
  
  func bind(_ resource: Feeds) {
    self.resource = resource
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    invalidateIntrinsicContentSize()
  }
  
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }
}

private extension FeedTableView {
  func setUpLayout() {
    
  }
  
  func setUpConstraints() {
    
  }
  
  func setUpConfigure() {
    self.backgroundColor = .white
    self.estimatedRowHeight = 300
    self.rowHeight = UITableView.automaticDimension
    self.isScrollEnabled = false
    self.separatorStyle = .none
    self.register(FeedCell.self, forCellReuseIdentifier: FeedCell.identifier)
    self.delegate = self
    self.dataSource = self
  }
}

extension FeedTableView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    resource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    createCell(indexPath)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension FeedTableView {
  func createCell(_ indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = self.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell
    else { return UITableViewCell() }
    
    let item = resource[indexPath.item]
    cell.bind(feed: item)
    
    return cell
  }
}
