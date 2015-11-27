//
//  FlickrPhotosViewController.swift
//  FlickSearch
//
//  Created by Ky Nguyen on 11/20/15.
//  Copyright © 2015 Snapbuck. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class FlickrPhotosViewController: UICollectionViewController {

    let resuseIdentifier = "FlickrSearch"
    let sectionInsets = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
    
    var searches = [FlickrSearchResults]()
    let flickr = Flickr()
    
    func photoForIndexPath(indexPath: NSIndexPath) -> FlickrPhoto {
        
        return searches[indexPath.section].searchResults[indexPath.row]
    }
    
    var largePhotoIndexPath : NSIndexPath? {
        
        didSet {
            
            var indexPaths = [NSIndexPath]()
            if largePhotoIndexPath != nil {
                
                indexPaths.append(largePhotoIndexPath!)
            }
            
            if oldValue != nil {
                
                indexPaths.append(oldValue!)
            }
            
            collectionView?.performBatchUpdates({ () -> Void in
                
                self.collectionView?.reloadItemsAtIndexPaths(indexPaths)
                }, completion: { (Bool) -> Void in
                    
                    if self.largePhotoIndexPath != nil {
                        
                        self.collectionView?.scrollToItemAtIndexPath(self.largePhotoIndexPath!, atScrollPosition: UICollectionViewScrollPosition.CenteredVertically, animated: true)
                    }
            })
        }
    }
}


