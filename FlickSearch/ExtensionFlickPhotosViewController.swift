//
//  ExtensionFlickPhotosViewController.swift
//  FlickSearch
//
//  Created by Ky Nguyen on 11/20/15.
//  Copyright © 2015 Snapbuck. All rights reserved.
//

import Foundation
import UIKit

extension FlickrPhotosViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        flickr.searchFlickrForTerm(textField.text!) { (results, error) -> Void in
            
            activityIndicator.removeFromSuperview()
            if error != nil {
                
                print(error)
            }
            
            if results != nil {
                
                print("Found \(results!.searchResults.count)")
                self.searches.insert(results!, atIndex: 0)
                
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return searches.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(resuseIdentifier, forIndexPath: indexPath) as! FlickrPhotoCell
        
        let flickrphoto = photoForIndexPath(indexPath)
        
        cell.imageView.image = flickrphoto.thumbnail
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "FlickrPhotoHeaderView", forIndexPath: indexPath) as! FlickrPhotoHeaderView
            
            headerView.label.text = searches[indexPath.section].searchTerm
            
            return headerView
            
        default:
            assert(false, "Unknown")
        }
    }
}

extension FlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let flickrPhoto = photoForIndexPath(indexPath)
        
        if let size = flickrPhoto.thumbnail?.size {
            
//            size.width += 5
//            size.height += 10
            return size
        }
        
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
}

