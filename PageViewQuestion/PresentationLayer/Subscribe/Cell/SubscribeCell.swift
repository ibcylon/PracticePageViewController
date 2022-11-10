//
//  SubscribeCell.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

final class SubscribeCell: UITableViewCell {
  static let identifier = "SubscribeCell"
  
  private let titleLabel = UILabel()
  private let contentLabel = UILabel()
  private let priceLabel = UILabel()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel, priceLabel])
    stackView.axis = .vertical
    stackView.distribution = .fill
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(subscribe: Subscribe) {
    self.titleLabel.text = subscribe.id
    self.contentLabel.text = subscribe.name
    self.priceLabel.text = "\(subscribe.price)"
  }
}

private extension SubscribeCell {
  func setUpLayout() {
    addViews()
    setUpConstraints()
  }
  
  func addViews() {
    [stackView].forEach { contentView.addSubview($0)}
  }
  
  func setUpConstraints() {
    contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    
    stackView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(20)
    }
  }
}
