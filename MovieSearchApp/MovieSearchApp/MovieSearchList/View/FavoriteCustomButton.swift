//
//  FavoriteCustomButton.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/14.
//

/*
 MovieSearchTopMenuView 에 있는 즐겨찾기 커스텀 버튼
 */

import UIKit

class FavoriteCustomButton : UIButton  {
  
  //MARK: - Properties
  private let starImageView : UIImageView = {
    let view = UIImageView()
    view.image = UIImage(systemName: "star.fill")
    view.tintColor = .yellow
    return view
  }() 
  
  private let textLabel : UILabel = {
    let label = UILabel()
    label.text = "즐겨찾기"
    label.textColor = .black
    return label
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
    self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 5
    
    [starImageView, textLabel].forEach {
      addSubview($0)
    }
    
    starImageView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(10)
      $0.width.height.equalTo(20)
    }
    
    textLabel.snp.makeConstraints {
      $0.centerY.equalTo(starImageView)
      $0.leading.equalTo(starImageView.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
  }
  
  //MARK: - @objc func
  
}
