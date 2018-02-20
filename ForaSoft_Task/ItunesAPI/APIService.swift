//
//  APIService.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

enum MediaType {
  
  // Media types from :
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
  
  static func allTypes() -> [Media] {
    return [.movie, .podcast, .music, .musicVideo, .audiobook, .shortFilm, .tvShow, .software, .ebook, .all]
  }
}

class APIService: NSObject {
  
  // Singleton instance
  static let sharedService = APIService()
  
  public func sendRequest(_ baseURL: String, parameters: [String: String], completion: @escaping ([String: Any]?, Error?) -> Void) {
    
    // Parse and add URL request parameters here from 'parameters' dict
    var components = URLComponents(string: baseURL)!
    components.queryItems = parameters.map { (key, value) in
      URLQueryItem(name: key, value: value)
    }
    
    // Need to escape + manually
    // More: https://stackoverflow.com/questions/41561853/couldnt-encode-plus-character-in-url-swift
    // And here: http://www.ietf.org/rfc/rfc1738.txt
    components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
    let request = URLRequest(url: components.url!)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data,
        let response = response as? HTTPURLResponse,  // get response
        (200 ..< 300) ~= response.statusCode,         // check status code and errors
        error == nil else {                           //
          completion(nil, error)                      // return error
          return
      }
      
      // deserialize and return data
      let responseObject = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
      completion(responseObject, nil)
    }
    task.resume()
  }
}
