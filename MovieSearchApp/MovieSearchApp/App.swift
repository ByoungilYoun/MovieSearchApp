//
//  App.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import Foundation

final class App {
  
  static let shared = App()
  
  let apiURL = URL(string: "https://openapi.naver.com/v1/search/movie.json")!
}
