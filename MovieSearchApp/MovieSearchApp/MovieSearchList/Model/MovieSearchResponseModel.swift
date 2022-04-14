//
//  MovieSearchResponseModel.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/15.
//

import Foundation

struct MovieSearchResponseModel : Decodable {
  var items : [Movie]?
}
