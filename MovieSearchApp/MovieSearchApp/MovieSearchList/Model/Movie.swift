//
//  Movie.swift
//  MovieSearchApp
//
//  Created by 윤병일 on 2022/04/15.
//

import Foundation

struct Movie : Decodable {
  var title : String?
  var link : String?
  var subtitle : String?
  var pubDate : String?
  var director : String?
  var actor : String?
  var userRating : String? // Int x
  var image : String?
  
  var isLiked : Bool
  
  
  private enum CodingKeys : String, CodingKey {
    case title, link, subtitle, pubDate, director, actor, userRating, image
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    title = try container.decodeIfPresent(String.self, forKey: .title) ?? "-"
    link = try container.decodeIfPresent(String.self, forKey: .link) ?? "-"
    subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? "-"
    pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? "-"
    director = try container.decodeIfPresent(String.self, forKey: .director) ?? "-"
    actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? "-"
    userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? "-"
    image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    isLiked = false
  }

  init(title: String, link : String, subtitle : String, pubDate : String, director : String, actor : String, userRating : String, imageURL : String,  isLiked : Bool = false) {
    self.title = title
    self.link = link
    self.subtitle = subtitle
    self.pubDate = pubDate
    self.director = director
    self.actor = actor
    self.userRating = userRating
    self.image = imageURL
    self.isLiked = isLiked
  }
}
