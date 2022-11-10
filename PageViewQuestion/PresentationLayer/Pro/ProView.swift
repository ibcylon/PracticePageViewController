//
//  ProView.swift
//  PageViewQuestion
//
//  Created by Bridge MacStudio on 2022/11/10.
//

import UIKit
import SnapKit

final class ProRootView: UIView {
  
  lazy var scrollView: CustomScrollView = {
    let scrollView = CustomScrollView()
    scrollView.addSubview(contentView)
    scrollView.delegate = self
    return scrollView
  }()
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  // MARK: Profile Section
  let profileImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "person.circle.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 63
    return imageView
  }()
  
  lazy var profileStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [nickNameLabel, subscribeButton])
    stackView.axis = .vertical
    stackView.spacing = 5
    stackView.distribution = .fill
    
    return stackView
  }()
  
  let nickNameLabel: UILabel = {
    let label = UILabel()
    label.text = "닉네임"
    return label
  }()
  
  lazy var subscribeButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 8
    button.clipsToBounds = true
    button.setTitle("Follow", for: .normal)
    button.setBackgroundColor(.blue, forState: .highlighted)
    button.setBackgroundColor(.systemBlue, forState: .normal)
    
    return button
  }()
  
  // MARK: Page Section
  // MARK: Tab Collection View
  lazy var tabCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(TabCell.self, forCellWithReuseIdentifier: TabCell.identifier)
    collectionView.collectionViewLayout = layout
    collectionView.backgroundColor = .white
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    return collectionView
  }()
  
  lazy var tabDataSource: [ProConstant.ProTabPage] = [.feed, .subscribe] {
    didSet {
      pageDataSource = []
      tabCollectionView.reloadData()
      tabDataSource.forEach { item in
        if case .feed = item {
          let scene = FeedViewController()
          pageDataSource.append(scene)
        }
        if case .subscribe = item {
          let scene = SubscribeViewController()
          pageDataSource.append(scene)
        }
      }
      
      if !tabDataSource.isEmpty {
        tabCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
      }
    }
  }
  
  // pageViewController 데이터 소스
  lazy var pageDataSource: [UIViewController] = [] {
    didSet {
      if let firstScene = pageDataSource.first {
        pageViewContoller.setViewControllers([firstScene], direction: .forward, animated: true)
      }
    }
  }
  
  var currentPage: Int = 0 {
    didSet {
      bind(oldValue: oldValue, newValue: currentPage)
      invalidateIntrinsicContentSize()
    }
  }
  
  // MARK: Page Section
  lazy var pageViewContoller: UIPageViewController = {
    let pager = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    pager.delegate = self
    pager.dataSource = self
    pager.view.translatesAutoresizingMaskIntoConstraints = false
    return pager
  }()
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    setLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // Data Binding
  func bind(_ pro: Pro) {
    tabDataSource = pro.pages
    pageDataSource.forEach { viewcontroller in
      if let feedScene = viewcontroller as? FeedViewController {
        feedScene.bind(pro.feed)
      }
      
      if let subscribeScene = viewcontroller as? SubscribeViewController {
        subscribeScene.bind(pro.subscribe)
      }
    }
    invalidateIntrinsicContentSize()
  }
  
  override var intrinsicContentSize: CGSize {
    let fixedHeight: CGFloat = 127 + 100
    let width = UIScreen.main.bounds.width
    return CGSize(width: width, height: fixedHeight + pageViewContoller.view.intrinsicContentSize.height)
  }
}

// MARK: Layout
private extension ProRootView {
  func setLayout() {
    addViews()
    setUpConstaints()
    setUpConfigure()
  }
  func addViews() {
    addSubview(scrollView)
    
    [
      profileImageView, profileStackView,
      tabCollectionView, pageViewContoller.view
    ].forEach { contentView.addSubview($0) }
  }
  
  func setUpConstaints() {
    scrollView.snp.makeConstraints {
      $0.top.bottom.equalTo(safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
    
    contentView.snp.makeConstraints {
      $0.edges.equalTo(scrollView.contentLayoutGuide)
      $0.width.equalTo(scrollView.frameLayoutGuide)
      // 스크롤 최소 길이
      $0.height.greaterThanOrEqualTo(scrollView.snp.height).priority(.low)
    }
    
    // MARK: Profile Section
    profileImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(20)
      $0.size.equalTo(126)
    }
    profileStackView.snp.makeConstraints {
      $0.top.bottom.equalTo(profileImageView)
      $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().inset(20)
    }
    
    subscribeButton.snp.makeConstraints {
      $0.height.equalTo(50)
    }
    
    // MARK: Tab Page Section
    tabCollectionView.snp.makeConstraints {
      $0.top.equalTo(profileImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(100)
    }
    
    pageViewContoller.view.setContentHuggingPriority(.defaultLow, for: .vertical)
    pageViewContoller.view.snp.makeConstraints {
      $0.top.equalTo(tabCollectionView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
//      $0.height.greaterThanOrEqualTo(500).priority(.low)
      $0.bottom.equalToSuperview()
    }
  }
  
  func setUpConfigure() {
    backgroundColor = .white
  }
  
  private func bind(oldValue: Int, newValue: Int) {
    let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
    pageViewContoller.setViewControllers([pageDataSource[newValue]], direction: direction, animated: true)
    tabCollectionView.selectItem(at: IndexPath(item: newValue, section: 0), animated: false, scrollPosition: .centeredVertically)
  }
}

extension ProRootView: UICollectionViewDataSource, UICollectionViewDelegate, TabCellDelegate {
  func didTapCell(_ cell: TabCell) {
    if let index = tabCollectionView.indexPath(for: cell)?.item {
      currentPage = index
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    tabDataSource.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCell.identifier, for: indexPath) as? TabCell
    else { return UICollectionViewCell() }
    
    let title = tabDataSource[indexPath.item].rawValue
    cell.bind(title)
    cell.delegate = self
    return cell
  }
  
}

extension ProRootView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
  }
}

extension ProRootView: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard
      let index = pageDataSource.firstIndex(of: viewController)
    else { return nil }
    let prev = index - 1
    return prev > 0 ? pageDataSource[prev] : nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard
      let index = pageDataSource.firstIndex(of: viewController)
    else { return nil }
    let next = index + 1
    return next == pageDataSource.count ? nil : pageDataSource[next]
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    guard
      let currentScene = pageViewController.viewControllers?.first,
      let currentIndex = pageDataSource.firstIndex(of: currentScene)
    else { return }
    currentPage = currentIndex
  }
}
