//
//  ListView.swift
//  GooTask
//
//  Created by mohamed hassan on 4/14/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit
import Foundation


class ListView: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
    
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell");
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let cashedData = defaults.value(forKey: "cashedData") {
            let list = cashedData as! NSArray
            print("cashedData :::>>>>>>>>>>")
            print(list.count)
            return list.count
        }
      return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // navigate to the book list page with the full data
        let MapViewPage :MapView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapView") as! MapView
        MapViewPage.ID = indexPath.row
        self.present(MapViewPage, animated: false, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // declare the cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let image = UIImage(named: "bg.jpg")
        cell.profileImage?.image = image?.circleMasked
        //cell.imageView?.image = image?.circleMasked

        
        return cell
    }
}


// extension to make image view as a circle
extension UIImage {
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let cgImage = cgImage?.cropping(to: CGRect(origin: CGPoint(x: isLandscape ? floor((size.width - size.height) / 2) : 0, y: isPortrait  ? floor((size.height - size.width) / 2) : 0), size: breadthSize)) else { return nil }
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage).draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
