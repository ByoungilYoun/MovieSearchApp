//
//  MovieListTableView.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import UIKit

class MovieListTableView : UITableView {
  
  //MARK: - Properties
  
  //MARK: - Init
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    attribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func attribute() {
    self.backgroundColor = .white
    self.tableFooterView = UIView()
    self.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
  }
}
