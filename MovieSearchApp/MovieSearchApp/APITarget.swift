//
//  APITarget.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import Moya

enum API {
  enum SearchMovie {
    case searchMovie(query : String)
  }
}

extension API.SearchMovie : TargetType, AccessTokenAuthorizable {
  var baseURL: URL {
    App.shared.apiURL
  }
  
  var sampleData: Data { Data() }
  
  var headers: [String : String]? {
    let headers = [
      "X-Naver-Client-Id": "FoXmM1B7gW2q8G0FUwAL",
      "X-Naver-Client-Secret": "JYcTdAiPWD"
    ]
    return headers
  }
  
  var path: String {
    switch self {
    case .searchMovie : return ""
    }
  }
  
  var method: Method {
    switch self {
    case .searchMovie : return .get
    }
  }
  
  var task: Task {
    switch self {
    case .searchMovie(let query) :
      return .requestParameters(parameters: ["query" : query], encoding: URLEncoding.default)
    }
  }
  
  var authorizationType: AuthorizationType? {
    return nil
  }

}
