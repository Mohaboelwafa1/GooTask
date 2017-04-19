//
//  MapView.swift
//  GooTask
//
//  Created by mohamed hassan on 4/15/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps

class MapView: UIViewController {
    
    var ID : Int!
    let defaults = UserDefaults.standard
    var mapView : GMSMapView = GMSMapView()
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var drawRouteButton: UIButton!
    
    
    override func viewDidLoad() {
        
        let cashedData = defaults.value(forKey: "cashedData")
        let list = cashedData as! NSArray
        let usedData = list[ID] as! NSDictionary
        
        let TransferID = usedData["TransferID"] as! String
        

        
        let FromAddress = usedData["FromAddress"] as! String
        let FromLat = Double(usedData["FromLat"] as! String)
        let FromLong = Double(usedData["FromLong"] as! String)
        
        let ToAddress = Double(usedData["ToAddress"] as! String)
        let ToLat = Double(usedData["ToLat"] as! String)
        let ToLong = Double(usedData["ToLong"] as! String)
        
       
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: FromLat!, longitude: FromLong! , zoom: 10.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the current location on the map.
        let fromMarker = GMSMarker()
        fromMarker.position = CLLocationCoordinate2D(latitude: FromLat!, longitude: FromLong!)
        fromMarker.icon = UIImage(named: "currentMarker")
        fromMarker.title = "CurrentLocation"
        fromMarker.snippet = "\(FromAddress)"
        fromMarker.map = mapView
        
        
        // Creates a marker in the destination location on the map.
        let toMarker = GMSMarker()
        toMarker.position = CLLocationCoordinate2D(latitude: ToLat!, longitude: ToLong!)
        toMarker.icon = UIImage(named: "distinationMarker")
        toMarker.title = "DistinationLocation"
        toMarker.snippet = "\(ToAddress)"
        toMarker.map = mapView
        
  
        
        let currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: FromLat!, longitude: FromLong!)
        let distinationLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: ToLat!, longitude: ToLong!)
        
        // draw route between the 2 locations
        self.getPolylineRoute(from: currentLocation, to: distinationLocation);
        
    }
    
    
    func showPath(polyStr :String){
        let path = GMSPath(fromEncodedPath: polyStr)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.map = mapView 
    }
    
    
    // Pass your source and destination coordinates in this method.
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "http://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        let routes = json["routes"] as? [Any]
                        let overview_polyline = routes?[0] as?[String:Any]
                        
                        let polyString = overview_polyline?["overview_polyline"] as?NSDictionary
                        self.showPath(polyStr: polyString?["points"] as! String!)
                    }
                    
                }catch{
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    
}
