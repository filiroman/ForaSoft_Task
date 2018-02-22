//
//  AlbumDetailTableViewCell.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 21/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {
  @IBOutlet weak var albumCover: UIImageView!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  var albumItem : SearchResultItem? = nil {
    didSet {
      updateData()
    }
  }
  
  func updateData() {
    albumLabel.text = albumItem?.albumName
    artistLabel.text = albumItem?.artistName
    
    guard let albumURL = albumItem?.artworkUrl else {
      return
    }
    albumCover.setImageFrom(url: albumURL)
    
  }

}
