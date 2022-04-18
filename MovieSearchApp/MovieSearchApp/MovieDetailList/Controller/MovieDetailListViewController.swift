//
//  MovieDetailListViewController.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class MovieDetailListViewController : UIViewController {
  
  //MARK: - Properties
  let detailMovie : Movie
  let movieDetailView = MovieDetailView()
  let movieDetailWebView = MovieDetailWebView()
  let disposeBag = DisposeBag()
  let favoriteViewModel = FavoriteMovieViewModel()
  
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
    bind()
    setNavigation()
    layout()
    setDetailMovieData()
    setMovieDetailWebView()
    setStarButtonIsLiked()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
  }
  
  //MARK: - Functions
  private func setNavigation() {
    self.navigationItem.title = detailMovie.title?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    
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
    self.movieDetailView.configureData(movie: detailMovie)
  }
  
  private func setMovieDetailWebView() {
    guard let movieLink = detailMovie.link else { return }
    self.movieDetailWebView.laodWebUrl(url: movieLink)
  }
  
  private func setStarButtonIsLiked() {
    self.movieDetailView.detailStarButton.imageView?.tintColor = detailMovie.isLiked ? UIColor.yellow : UIColor.lightGray
  }
  
  func bind() {
    self.movieDetailView.detailStarButton.rx.tap.bind { [weak self] _ in
      guard let self = self else { return }
      
      var movie = self.detailMovie
      
      movie.isLiked.toggle()
      
      if movie.isLiked {
        self.movieDetailView.detailStarButton.imageView?.tintColor = .yellow
        self.favoriteViewModel.addMovie(movie)
      } else {
        self.movieDetailView.detailStarButton.imageView?.tintColor = .lightGray
        self.favoriteViewModel.removeMovie(movie)
      }
      
    }.disposed(by: self.disposeBag)
  }

  //MARK: - @objc func
  @objc private func goBack() {
    self.navigationController?.popViewController(animated: true)
  }
}
