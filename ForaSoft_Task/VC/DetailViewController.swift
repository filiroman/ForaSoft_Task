//
//  DetailViewController.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 21/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
  
  private var albumSongs = [SearchResultItem]()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  var albumItem : SearchResultItem? = nil {
    didSet {
      updateData()
    }
  }
  
  func updateData() {
    
    guard let itemID = self.albumItem?.itemID else { return }
    let params = ["id":itemID]
    
    IndicatorView.sharedIndicator.showLoading()
    
    APISearchManager.sharedManager.fetchMedia(with: params, media: Constants.Media.music, entity: Constants.Entity.song) { songs, error in
      
      self.albumSongs.removeAll()
      self.albumSongs.append(contentsOf: songs!)
      self.tableView?.reloadData()
      
      IndicatorView.sharedIndicator.hideLoading()
    }
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      return 1
    }
    
    return albumSongs.count
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if (indexPath.section == 0) {
      let cell = tableView.dequeueReusableCell(withIdentifier: "detailTopCell", for: indexPath) as! AlbumDetailTableViewCell
      cell.albumItem = self.albumItem
      return cell
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "detailSongCell", for: indexPath)
    
    cell.textLabel?.text = self.albumSongs[indexPath.row].trackName
    return cell
  }
}
