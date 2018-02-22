//
//  APISearchManager.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

// A dedicated interface to search for media entities
class APISearchManager: NSObject {
  
  // Singleton instance
  static let sharedManager = APISearchManager()
  
  func fetchMedia(with params: [String:String], media: Constants.Media, entity: Constants.Entity, completion: @escaping ([SearchResultItem]?,Error?) -> Void) {
    
    var parameters = params
    parameters["media"] = media.rawValue
    parameters["entity"] = entity.rawValue
    
    //TODO: add other types of media
    if media == Constants.Media.music {
      
      if entity == Constants.Entity.album {
        
        APIService.sharedService.search(parameters) { responseObject, error in
          guard let json = responseObject, error == nil else {
            
            print(error ?? "Unknown error")
            DispatchQueue.main.async(execute: {
              completion(nil, error)
            })
            return
          }
          
          guard let results = json["results"] as? [JSONDict] else { return }
          var albums = [SearchResultItem]()
          
          for result in results {
            if let albumID = result["collectionId"] as? Int,
              let artistName = result["artistName"] as? String,
              let albumName = result["collectionName"] as? String,
              let artworkUrlStr = result["artworkUrl100"] as? String {
              
              guard let artworkUrl = URL(string: artworkUrlStr) else { return }
              
              let nextItem = SearchResultItem()
              nextItem.itemID = String(albumID)
              nextItem.albumName = albumName
              nextItem.artistName = artistName
              nextItem.artworkUrl = artworkUrl
              
              albums.append(nextItem)
            }
          }
          DispatchQueue.main.async(execute: {
            completion(albums, nil)
          })
        }
      }
      
      else if entity == Constants.Entity.song {
        
        // We search for song via "lookup" API
        APIService.sharedService.lookup(parameters) { responseObject, error in
          guard let json = responseObject, error == nil else {
            
            print(error ?? "Unknown error")
            DispatchQueue.main.async(execute: {
              completion(nil, error)
            })
            return
          }
          
          guard let results = json["results"] as? [JSONDict] else { return }
          var albums = [SearchResultItem]()
          
          for result in results {
            if let trackID = result["trackId"] as? Int,
              let artistName = result["artistName"] as? String,
              let trackName = result["trackName"] as? String,
              let albumName = result["collectionName"] as? String,
              let artworkUrlStr = result["artworkUrl100"] as? String {
              
              guard let artworkUrl = URL(string: artworkUrlStr) else { return }
              
              let nextItem = SearchResultItem()
              nextItem.itemID = String(trackID)
              nextItem.albumName = albumName
              nextItem.artistName = artistName
              nextItem.trackName = trackName
              nextItem.artworkUrl = artworkUrl
              
              albums.append(nextItem)
            }
          }
          DispatchQueue.main.async(execute: {
            completion(albums, nil)
          })
        }
      }
      
    } else {
      
      // This is for debug only
      print("APISearchManager/fetchMedia UNSUPPORTED media!!! ")
    }
  }
}
