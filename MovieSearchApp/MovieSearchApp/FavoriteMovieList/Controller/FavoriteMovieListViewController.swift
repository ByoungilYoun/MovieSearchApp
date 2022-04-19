//
//  FavoriteMovieListViewController.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/18.
//

import UIKit

class FavoriteMovieListViewController : UIViewController {
  
  //MARK: - Properties
  let favoriteListTableView = MovieListTableView()
  
  let viewModel = FavoriteMovieViewModel()
  var savedMovie : [Movie] = []
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    layout()
    setTableViewDelegate()
    self.savedMovie = viewModel.getMovies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  //MARK: - Functions
  private func setNavigation() {
    self.navigationItem.title = "즐겨찾기 목록"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkBtnTap))
    self.navigationItem.leftBarButtonItem?.tintColor = .black
  }
  
  private func layout() {
    view.backgroundColor = .white
    
    view.addSubview(self.favoriteListTableView)
    self.favoriteListTableView.snp.makeConstraints {
      $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func setTableViewDelegate() {
    self.favoriteListTableView.delegate = self
    self.favoriteListTableView.dataSource = self
  }
  
  //MARK: - @objc func
  
  @objc private func xmarkBtnTap() {
    self.navigationController?.popViewController(animated: true)
  }
}

  //MARK: - UITableViewDataSource
extension FavoriteMovieListViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getMovies().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as? MovieListTableViewCell else {
      return UITableViewCell()
    }
    cell.selectionStyle = .none
    cell.configureCell(movieData: savedMovie[indexPath.row])
    cell.bind(movieData: savedMovie[indexPath.row])
    return cell
  }
  
  
}

  //MARK: - UITableViewDelegate
extension FavoriteMovieListViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = MovieDetailListViewController(detailMovie: savedMovie[indexPath.row])
    
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}
