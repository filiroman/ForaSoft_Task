//
//  AlbumCell.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
  @IBOutlet weak var albumCover: UIImageView!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  
  var albumItem : SearchResultItem? = nil {
    didSet {
      updateData()
    }
  }
  
  func updateData() {
    albumLabel.text = albumItem?.albumName
    artistLabel.text = albumItem?.artistName
    albumCover.setImageFrom(url: (albumItem?.artworkUrl)!)
    
  }
}
