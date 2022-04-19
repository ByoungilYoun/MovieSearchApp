//
//  Service.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import Moya
import RxSwift

class Service <T : TargetType> {
  let accessTokenPlugIn = AccessTokenPlugin { _ in
    return ""
  }
  
  func request(_ api : T) -> Single<Response> {
    Single<Response>.create { single in
      
      MoyaProvider<T>(plugins: [self.accessTokenPlugIn]).request(api) { result in
        switch result {
        case .success(let response) :
          single(.success(response))
        case .failure(let error) :
          single(.failure(error))
        }
      }
      return Disposables.create()
    }
  }
}
