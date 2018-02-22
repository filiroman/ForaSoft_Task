//
//  UICollectionView+EmptyMessage.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 22/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

extension UICollectionView {

  // Showing a message when collectionView is empty
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont.systemFont(ofSize: 16)
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel;
  }
  
  func resetEmptyMessage() {
    self.backgroundView = nil
  }
}
