//
//  MovieSearchListViewController.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/14.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MovieSearchListViewController : UIViewController {
  
  //MARK: - Properties
  private let topMenuView = MovieSearchTopMenuView()
  private let searchController = UISearchController()
  
  private let disposeBag = DisposeBag()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - Functions
  
  private func configureUI() {
    view.backgroundColor = .white
    
    [topMenuView].forEach {
      view.addSubview($0)
    }
    
    topMenuView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
  }

  func bind() {
    topMenuView.favoriteButton.rx.tap.subscribe { _ in
      print("즐겨찾기 이동")
    }.disposed(by: self.disposeBag)
  }
 
  
  //MARK: - @objc func
  
  
}
