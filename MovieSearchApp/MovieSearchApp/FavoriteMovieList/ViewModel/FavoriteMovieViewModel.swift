//
//  FavoriteMovieViewModel.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/18.
//

import Foundation
import RxRelay

enum Key : String {
  case movie
}

struct FavoriteMovieViewModel {

  //MARK: - Properties

  //MARK: - Functions
  func getMovies() -> [Movie] {
    guard let data = UserDefaults.standard.data(forKey: Key.movie.rawValue) else {
      return []
    }

    return (try? PropertyListDecoder().decode([Movie].self, from: data)) ?? []
  }

  func addMovie(_ newValue : Movie) {
    var currentMovies : [Movie] = getMovies()
    currentMovies.insert(newValue, at: 0)

    // 새로 저장
    saveMovie(currentMovies)
  }

  func removeMovie(_ value : Movie) {
    let currentMovies : [Movie] = getMovies()
    let newValue = currentMovies.filter {
      $0.link != value.link // 지우고자 한 값을 제외한 총 movie 값, link 로?
    }

    // 지우고 새로 저장
    saveMovie(newValue)
  }


  private func saveMovie(_ newValue : [Movie]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: Key.movie.rawValue)
  }

}
