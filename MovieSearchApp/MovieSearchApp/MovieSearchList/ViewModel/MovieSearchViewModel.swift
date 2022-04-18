//
//  MovieSearchViewModel.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class MovieSearchViewModel {
  
  //MARK: - Properties
  let searchMovieResponseData = BehaviorRelay<MovieSearchResponseDto?>(value: nil)
  
  private let disposeBag = DisposeBag()
  
  //MARK: - Functions
  
  // query 로 영화 찾기 호출 함수
  func searchMovie(with query : String) {
    Service<API.SearchMovie>().request(.searchMovie(query: query)).subscribe(onSuccess: { response in
      
      guard let json = try? response.mapJSON() as? [String : Any] else {
        return
      }
      
      guard (200..<300).contains(response.statusCode) else {
        return
      }
      
      guard let movieSearchData = MovieSearchResponseDto(JSON: json) else {
        return
      }
      
      self.searchMovieResponseData.accept(movieSearchData)
    }, onFailure : { error in
      print(error.localizedDescription)
    }).disposed(by: self.disposeBag)
  }
  
  // 영화 총 갯수 가져오는 함수
  func getMovieListCount() -> Int {
    return searchMovieResponseData.value?.items?.count ?? 0
  }
  
  // 각 영화 정보 데이터 가져오는 함수
  func getEachMovieData(indexPath : Int) -> Movie? {
    guard let item = searchMovieResponseData.value else { return nil }
    guard let movie = item.items else { return nil }
    return movie[indexPath]
  }
}
