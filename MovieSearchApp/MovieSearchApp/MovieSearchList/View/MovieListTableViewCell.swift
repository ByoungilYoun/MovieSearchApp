//
//  MovieListTableViewCell.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/15.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class MovieListTableViewCell : UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "MovieListTableViewCell"
  private let disposeBag = DisposeBag()
  
  let movieImageView : UIImageView = {
    let view = UIImageView()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.backgroundColor = .lightGray
    return view
  }()
  
  let movieTitleLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
  }()
  
  let directorLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let actorLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let ratingLabel : UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.lineBreakMode = .byTruncatingTail
    label.font = UIFont.systemFont(ofSize: 13)
    return label
  }()
  
  let starButton : UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "star.fill"), for: .normal)
    button.imageView?.tintColor = .lightGray
    return button
  }()
  
  //MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    movieImageView.image = nil
  }
  
  //MARK: - Functions
  private func layout() {
    backgroundColor = .white
    
    let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, directorLabel, actorLabel, ratingLabel])
    stackView.axis = .vertical
    stackView.spacing = 2
    stackView.distribution = .fillEqually
    
    [movieImageView, stackView, starButton].forEach {
      contentView.addSubview($0)
    }
    
    movieImageView.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top).offset(10)
      $0.leading.equalTo(contentView.snp.leading).offset(10)
      $0.width.equalTo(55)
      $0.height.equalTo(80)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(movieImageView)
      $0.leading.equalTo(movieImageView.snp.trailing).offset(5)
      $0.trailing.equalTo(starButton.snp.leading).offset(-5)
      $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
    }
    
    starButton.snp.makeConstraints {
      $0.top.equalTo(movieImageView)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-10)
      $0.width.equalTo(20)
      $0.height.equalTo(17)
    }
  }
  
  func configureCell(movieData : Movie) {
    let url = URL(string: movieData.image ?? "")
    movieImageView.kf.setImage(with: url)
    
    movieTitleLabel.text = movieData.title?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
    directorLabel.text = "감독 : \(movieData.director ?? "")".replacingOccurrences(of: "|", with: "")
    actorLabel.text = "출연 : \(movieData.actor ?? "")".replacingOccurrences(of: "|", with: ",")
    ratingLabel.text = "평점 : \(movieData.userRating ?? "")"
  }
}

