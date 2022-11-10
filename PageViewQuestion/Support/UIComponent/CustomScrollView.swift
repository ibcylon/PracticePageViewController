//
//  CustomScrollView.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

class CustomScrollView: UIScrollView {
  init() {
    super.init(frame: .zero)
    
    canCancelContentTouches = true
    delaysContentTouches = false
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesShouldCancel(in view: UIView) -> Bool {
    if view is UIButton {
      return true
    }
    
    return super.touchesShouldCancel(in: view)
  }
}
