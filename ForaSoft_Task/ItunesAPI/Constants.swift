//
//  Constants.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import Foundation

struct Constants {
  
  static let baseURL = "https://itunes.apple.com/"
  static let baseSearchURL = Constants.baseURL + "search"
  static let baseLookupURL = Constants.baseURL + "lookup"
  
  enum Media : String {
    
    // Media field from :
    // https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
    //
    case movie
    case podcast
    case music
    case musicVideo
    case audiobook
    case shortFilm
    case tvShow
    case software
    case ebook
    case all
    
  }
  
  // Entity fields from :
  // https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/
  //
  enum Entity : String {
    
    // Media.music
    case musicArtist
    case musicTrack
    case album
    case musicVideo
    case mix
    case song
    
    // TODO: add enums for other Media types
  }
}
