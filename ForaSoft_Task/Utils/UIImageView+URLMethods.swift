//
//  UIImageView+URLMethods.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

// define a cache for images
let imagesCache = NSCache<NSString, UIImage>()

extension UIImageView {
  public func setImageFrom(url: URL) {
    
    if let cachedImage = imagesCache.object(forKey: url.absoluteString as NSString) {
      self.image = cachedImage
      return
    }
    
    URLSession.shared.dataTask(with: url){ data, response, error in
      if error != nil {
        print(error.debugDescription)
        return
      }
      DispatchQueue.main.async(execute: {
        let image = UIImage(data: data!)
        imagesCache.setObject(image!, forKey: url.absoluteString as NSString)
        self.image = image
      })
    }.resume()
  }}
