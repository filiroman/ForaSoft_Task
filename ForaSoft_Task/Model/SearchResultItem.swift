//
//  SearchResultItem.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import Foundation

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
