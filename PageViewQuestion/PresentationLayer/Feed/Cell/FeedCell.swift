//
//  FeedCell.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

final class FeedCell: UITableViewCell {
  static let identifier = "FeedCell"
  
  private let titleLabel = UILabel()
  private let contentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(feed: Feed) {
    self.titleLabel.text = feed.title
    self.contentLabel.text = feed.content
  }
}

private extension FeedCell {
  func setUpLayout() {
    addViews()
    setUpConstraints()
  }
  
  func addViews() {
    [titleLabel, contentLabel].forEach { contentView.addSubview($0)}
  }
  
  func setUpConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(20)
    }
    
    contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.trailing.bottom.equalToSuperview().inset(20)
    }
  }
}


