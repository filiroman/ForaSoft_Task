//
//  IndicatorView.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 22/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

class IndicatorView: NSObject {
  
  static let sharedIndicator = IndicatorView()
  private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
  
  public func showLoading() {
    
    let mainWindow = UIApplication.shared.keyWindow!
    activityIndicator.center = mainWindow.center
    activityIndicator.startAnimating()
    mainWindow.addSubview(activityIndicator)
  }
  
  public func hideLoading() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
  }
  
  private override init() {
    super.init()
    
    // customization
    activityIndicator.frame = CGRect(origin: activityIndicator.center, size: CGSize(width: 60, height: 60))
    activityIndicator.backgroundColor = UIColor.gray
  }
}
