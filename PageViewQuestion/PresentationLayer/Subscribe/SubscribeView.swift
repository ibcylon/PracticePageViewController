//
//  SubscribeView.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit
import SnapKit

final class SubscribeView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SubscribeView {
  func setLayout() {
    addViews()
    setUpConstraints()
  }
  
  func addViews() {
    
  }
  
  func setUpConstraints() {
    
  }
}
