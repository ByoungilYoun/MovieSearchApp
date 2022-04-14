//
//  MovieSearchNetworkManager.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/15.
//

import Foundation
import Alamofire

struct MovieSearchNetworkManager {
  func request(from query : String, completionHandler : @escaping ([Movie]) -> Void) {
    guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
    
    let parameters = MovieSearchRequestModel(query: query)
    print("하하 query : \(query)")
    let headers : HTTPHeaders = [
      "X-Naver-Client-Id": "FoXmM1B7gW2q8G0FUwAL",
      "X-Naver-Client-Secret": "JYcTdAiPWD"
    ]
    
    AF.request(url, method: .get, parameters: parameters, headers: headers)
      .responseDecodable(of: MovieSearchResponseModel.self) { response in
        switch response.result {
        case .success(let data) :
          print("하하 여기 2")
          guard let movieData = data.items else { return }
          completionHandler(movieData)
        case .failure(let error) :
          print("하하 여기 3")
          print(error.localizedDescription)
        }
      }.resume()
  }
}
