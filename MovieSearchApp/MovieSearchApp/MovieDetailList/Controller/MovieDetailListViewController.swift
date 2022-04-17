//
//  MovieDetailListViewController.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import UIKit
import WebKit

class MovieDetailListViewController : UIViewController {
  
  //MARK: - Properties
  let detailMovie : Movie?
  let movieDetailView = MovieDetailView()
  let movieDetailWebView = MovieDetailWebView()
  
  //MARK: - Init
  init(detailMovie : Movie) {
    self.detailMovie = detailMovie
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    layout()
    setDetailMovieData()
    setMovieDetailWebView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  //MARK: - Functions
  private func setNavigation() {
    self.navigationItem.title = detailMovie?.title?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(goBack))
    self.navigationItem.leftBarButtonItem?.tintColor = .black
  }
  
  private func layout() {
    view.backgroundColor = .white
    
    [movieDetailView, movieDetailWebView].forEach {
      self.view.addSubview($0)
    }
    
    self.movieDetailView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(100)
    }
    
    self.movieDetailWebView.snp.makeConstraints {
      $0.top.equalTo(movieDetailView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setDetailMovieData() {
    guard let movie = detailMovie else { return }
    self.movieDetailView.configureData(movie: movie)
  }
  
  private func setMovieDetailWebView() {
    guard let movieLink = detailMovie?.link else { return }
    self.movieDetailWebView.laodWebUrl(url: movieLink)
  }
  
  //MARK: - @objc func
  @objc private func goBack() {
    self.navigationController?.popViewController(animated: true)
  }
}
