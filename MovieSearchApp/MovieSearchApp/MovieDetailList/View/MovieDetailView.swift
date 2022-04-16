//
//  MovieDetailView.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import UIKit
import Kingfisher

class MovieDetailView : UIView {
  
  //MARK: - Properties
  let detailMovieImageView : UIImageView = {
    let view = UIImageView()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.backgroundColor = .lightGray
    return view
  }()
  
  let detailDirectorLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let detailActorLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let detailRatingLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let detailStarButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "star.fill"), for: .normal)
    button.imageView?.tintColor = .lightGray
    return button
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func layout() {
    self.backgroundColor = .white
    
    let stackView = UIStackView(arrangedSubviews: [detailDirectorLabel, detailActorLabel, detailRatingLabel])
    stackView.axis = .vertical
    stackView.spacing = 2
    stackView.distribution = .fillEqually
    
    [detailMovieImageView, stackView, detailStarButton].forEach {
      self.addSubview($0)
    }
    
    detailMovieImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(10)
      $0.width.equalTo(55)
      $0.height.equalTo(80)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(detailMovieImageView)
      $0.leading.equalTo(detailMovieImageView.snp.trailing).offset(5)
      $0.trailing.equalTo(detailStarButton.snp.leading).offset(-5)
      $0.bottom.equalToSuperview().offset(-5)
    }
    
    detailStarButton.snp.makeConstraints {
      $0.top.equalTo(detailMovieImageView)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.equalTo(20)
      $0.height.equalTo(17)
    }
  }
  
  func configureData(movie : Movie) {
    let url = URL(string: movie.image ?? "")
    detailMovieImageView.kf.setImage(with: url)
    
    detailDirectorLabel.text = "감독 : \(movie.director ?? "")".replacingOccurrences(of: "|", with: "")
    detailActorLabel.text = "출연 : \(movie.actor ?? "")".replacingOccurrences(of: "|", with: ",")
    detailRatingLabel.text = "평점 : \(movie.userRating ?? "")"
  }
  
}
