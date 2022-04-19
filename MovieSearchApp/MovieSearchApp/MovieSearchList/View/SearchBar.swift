//
//  SearchBar.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/14.
//

import UIKit

class SearchBar : UISearchBar {
  
  //MARK: - Properties
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    searchTextField.textColor = .black
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
