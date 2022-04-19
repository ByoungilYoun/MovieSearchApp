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
  let movieListTableView = MovieListTableView()
  let viewModel = MovieSearchViewModel()
  
  private let disposeBag = DisposeBag()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    layout()
    setTableViewDelegate()
    setSearchBarDelegate()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  //MARK: - Functions
  private func layout() {
    view.backgroundColor = .white
    
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
  
  private func setTableViewDelegate() {
    self.movieListTableView.delegate = self
    self.movieListTableView.dataSource = self
  }
  
  private func setSearchBarDelegate() {
    self.searchBar.delegate = self
  }
  
  func bind() {
    topMenuView.favoriteButton.rx.tap.subscribe { _ in
      let viewController = FavoriteMovieListViewController()
      self.navigationController?.pushViewController(viewController, animated: true)
    }.disposed(by: self.disposeBag)
    
    viewModel.searchMovieResponseData.bind { [weak self] data in
      guard let self = self else { return }
      self.movieListTableView.reloadData()
    }.disposed(by: self.disposeBag)
  }
}

//MARK: - UISearchBarDelegate
extension MovieSearchListViewController : UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let text = searchBar.text else { return }
    viewModel.searchMovie(with: text)
  }
}

//MARK: - UITableViewDataSource
extension MovieSearchListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getMovieListCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    
    guard let movie = viewModel.getEachMovieData(indexPath: indexPath.row) else { return UITableViewCell() }
    cell.configureCell(movieData: movie)
    cell.bind(movieData: movie)
    return cell
  }
}

//MARK: - UITableViewDelegate
extension MovieSearchListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let selectedMovie = viewModel.searchMovieResponseData.value?.items?[indexPath.row] else { return }
    let viewController = MovieDetailListViewController(detailMovie: selectedMovie)
    self.navigationController?.pushViewController(viewController, animated: true)
    self.view.endEditing(true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}
