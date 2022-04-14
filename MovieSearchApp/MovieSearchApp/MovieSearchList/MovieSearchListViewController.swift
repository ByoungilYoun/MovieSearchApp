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
  let searchBar = SearchBar()
  let movieListTableView = UITableView()
  
  private let disposeBag = DisposeBag()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    layout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  //MARK: - Functions
  
  private func layout() {
    view.backgroundColor = .white
    
    attributeTableView()
    
    [topMenuView, searchBar, movieListTableView].forEach {
      view.addSubview($0)
    }
    
    topMenuView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    searchBar.snp.makeConstraints {
      $0.top.equalTo(topMenuView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
    
    movieListTableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func attributeTableView() {
    movieListTableView.backgroundColor = .white
    movieListTableView.delegate = self
    movieListTableView.dataSource = self
    movieListTableView.tableFooterView = UIView()
    movieListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }

  func bind() {
    topMenuView.favoriteButton.rx.tap.subscribe { _ in
      print("즐겨찾기 이동")
    }.disposed(by: self.disposeBag)
  }
}

  //MARK: - UITableViewDataSource
extension MovieSearchListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .white
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension MovieSearchListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("\(indexPath.row)")
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}
