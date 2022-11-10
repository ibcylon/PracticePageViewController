//
//  ViewController.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit

final class ProViewController: UIViewController {
  
  let mainView = ProRootView()
  var viewModel: ProViewModel!
  
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigation()
    bind()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  private func bind() {
    Task {
      let result: Pro
      result = try await viewModel.loadProfile(id: "asdf")
      
      await MainActor.run {
        mainView.bind(result)
        
        // notify the ChildScene transition Complete
        mainView.pageViewContoller.didMove(toParent: self)
      }
    }
  }
}

private extension ProViewController {
  func setNavigation() {
    self.title = "프로필"
  }
}

private extension ProViewController {
//  var profileBinding: Binder<Profile> {
//    return Binder(self) { scene, profile in
//      scene.mainView.bind(profile)
//    }
//  }
}

