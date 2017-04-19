//
//  GridView.swift
//  GooTask
//
//  Created by mohamed hassan on 4/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit


class GridView: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    //var ID : Int!
    let defaults = UserDefaults.standard
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        
        // 333
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let cashedData = defaults.value(forKey: "cashedData") {
            let list = cashedData as! NSArray
            print("cashedData :::>>>>>>>>>>")
            print(list.count)
            return list.count
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomGridViewCell
        
        let image = UIImage(named: "bg.jpg")
        cell.imageView?.image = image?.circleMasked

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // select item
        // navigate to the book list page with the full data
        let MapViewPage :MapView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapView") as! MapView
        MapViewPage.ID = indexPath.row
        self.present(MapViewPage, animated: false, completion: nil)
        
    }
}
