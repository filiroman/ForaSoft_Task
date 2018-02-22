//
//  SearchViewController.swift
//  ForaSoft_Task
//
//  Created by Roman Filippov on 20/02/2018.
//  Copyright © 2018 romanfilippov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "albumCell"

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
  
  private var albums : Array<SearchResultItem> = Array<SearchResultItem>()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    self.clearsSelectionOnViewWillAppear = true
    self.collectionView?.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "emptyHeader")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showErrorWithDescription(desc: String) {
    
    let alert = UIAlertController(title: "Error", message: desc, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func searchForTerm(term: String) {
    
    IndicatorView.sharedIndicator.showLoading()
    APISearchManager.sharedManager.fetchMedia(with: ["term":term], media: Constants.Media.music, entity: Constants.Entity.album) { albums, error in
      
      if let error = error {
        
        print("Error: ", error)
        self.showErrorWithDescription(desc: error.localizedDescription)
        
      } else if let albums = albums {
        
        self.albums.removeAll()
        //NOTE: Albums now are sorted in place for simplicity, in the future we can move that to a closure variable
        //      in fetchMedia func
        self.albums.append(contentsOf: albums.sorted(by: { $0.albumName! < $1.albumName! }))
        self.collectionView?.reloadSections(IndexSet([1]))
        
      }
      IndicatorView.sharedIndicator.hideLoading()
    }
  }
  
  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let vc = segue.destination as! DetailViewController
    let selectedIndex = self.collectionView?.indexPathsForSelectedItems![0].row
    vc.albumItem = self.albums[selectedIndex!]
  }
  

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }


  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if (section == 0) {
      return 0
    }
    
    if (albums.count == 0) {
      self.collectionView?.setEmptyMessage("Nothing to show :(")
    } else {
      self.collectionView?.resetEmptyMessage()
    }
    return albums.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell : AlbumCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
  
      cell.albumItem = albums[indexPath.row]
      return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if (indexPath.section == 1)
    {
      self.performSegue(withIdentifier: "showDetail", sender: self)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if (section == 0) {
      return CGSize(width: view.frame.width, height: 56)
    }
    return CGSize.zero
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    if (kind == UICollectionElementKindSectionHeader) {
     
      if (indexPath.section == 0) {
        let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchBarHeader", for: indexPath)
        return headerView
      }
      
      //return empty header view
      if (indexPath.section == 1) {
          return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "emptyHeader", for: indexPath)
      }
    }
    return UICollectionReusableView()
  }
  
  //MARK: - SEARCH BAR
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if(!(searchBar.text?.isEmpty)!){
      searchForTerm(term: searchBar.text!)
    }
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if(!searchText.isEmpty){
      searchForTerm(term: searchBar.text!)
    }
  }

}
