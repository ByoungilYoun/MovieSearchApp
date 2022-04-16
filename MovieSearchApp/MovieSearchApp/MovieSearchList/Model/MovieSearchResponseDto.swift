//
//  MovieSearchResponseDto.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/17.
//

import ObjectMapper

struct MovieSearchResponseDto : Mappable {
  var items : [Movie]?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    self.items <- map["items"]
  }
}

struct Movie : Mappable {
  var title : String?
  var link : String?
  var subtitle : String?
  var pubDate : String?
  var director : String?
  var actor : String?
  var userRating : String? // Int x
  var image : String?
  
  init?(map: Map) {
  
  }
  
  mutating func mapping(map: Map) {
    self.title <- map["title"]
    self.link <- map["link"]
    self.subtitle <- map["subtitle"]
    self.pubDate <- map["pubDate"]
    self.director <- map["director"]
    self.actor <- map["actor"]
    self.userRating <- map["userRating"]
    self.image <- map["image"]
  }
}
