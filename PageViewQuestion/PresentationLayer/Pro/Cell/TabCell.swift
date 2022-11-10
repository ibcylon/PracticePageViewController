//
//  TabCell.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit
import SnapKit

protocol TabCellDelegate: NSObjectProtocol {
  func didTapCell(_ cell: TabCell)
}

final class TabCell: UICollectionViewCell {
  static let identifier = "TabCell"
  
  weak var delegate: TabCellDelegate?
  
  lazy var pageLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
    label.addGestureRecognizer(tap)
    label.isUserInteractionEnabled = true
    return label
  }()
  
  let indicator: UIView = {
    let view = UIView()
    view.isHidden = true
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func bind(_ title: String) {
    pageLabel.text = title
  }
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        print("\(pageLabel.text ?? "") 선택됨")
        indicator.backgroundColor = .lightGray
        pageLabel.textColor = .lightGray
        indicator.isHidden = false
      } else {
        indicator.backgroundColor = .clear
        pageLabel.textColor = .black
        indicator.isHidden = true
      }
    }
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    
    delegate = nil
  }
}

private extension TabCell {
  func setLayout() {
    [pageLabel, indicator].forEach { contentView.addSubview($0) }
    
    setUpConstraints()
  }
  
  func setUpConstraints() {
    pageLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(5)
      $0.height.greaterThanOrEqualTo(50)
    }
    
    indicator.snp.makeConstraints {
      $0.top.equalTo(pageLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(5)
      $0.bottom.equalToSuperview()
    }
  }
  @objc
  func didTapLabel(_ sender: UILabel) {
    delegate?.didTapCell(self)
  }
}
