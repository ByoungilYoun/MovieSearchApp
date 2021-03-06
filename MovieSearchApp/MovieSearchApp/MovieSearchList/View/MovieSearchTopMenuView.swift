//
//  MovieSearchTopMenuView.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/14.
//

/*
 네이버 영화 검색, 즐겨찾기 버튼 있는 커스텀 뷰
 */

import UIKit

class MovieSearchTopMenuView : UIView  {
  
  //MARK: - Properties
  private let titleLabel : UILabel = {
    let label = UILabel()
    label.text = "네이버 영화 검색"
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 20)
    return label
  }()
  
  let favoriteButton = FavoriteCustomButton()
  
  
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
    [titleLabel, favoriteButton].forEach {
      addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    favoriteButton.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalToSuperview().offset(-15)
      $0.height.equalTo(30)
    }
  }
}
