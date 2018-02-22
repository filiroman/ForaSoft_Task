//
//  SearchResultItem.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import Foundation

//NOTE: I've created one class for both album and song entities for simplicity
//      (they have a lot in  common)
//      In future it's easy to subclass SearchResultItem and inline other entities explicitly
class SearchResultItem : NSObject {
  var itemID: String?
  var desc: String?
  var wrapperType: String?
  var trackName: String?
  var artistName: String?
  var albumName: String?
  var artworkUrl: URL?
  var storeUrl: URL?
  var releaseDate: String?
  
}
