//
//  SubscribeTableView.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit
import SnapKit

class SubscribeTableView: UITableView {
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: .zero, style: .insetGrouped)
    setUpLayout()
    setUpConfigure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var resource: Subscribes = [] {
    didSet {
      self.reloadData()
    }
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    
    invalidateIntrinsicContentSize()
  }
  
  override var intrinsicContentSize: CGSize {
    return self.contentSize
  }
  
  func bind(_ resource: Subscribes) {
    self.resource = resource
  }
}

private extension SubscribeTableView {
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
    self.register(SubscribeCell.self, forCellReuseIdentifier: SubscribeCell.identifier)
    self.delegate = self
    self.dataSource = self
  }
}

extension SubscribeTableView: UITableViewDataSource, UITableViewDelegate {
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

extension SubscribeTableView {
  func createCell(_ indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = self.dequeueReusableCell(withIdentifier: SubscribeCell.identifier, for: indexPath) as? SubscribeCell
    else { return UITableViewCell() }
    
    let item = resource[indexPath.item]
    cell.bind(subscribe: item)
    
    return cell
  }
}
