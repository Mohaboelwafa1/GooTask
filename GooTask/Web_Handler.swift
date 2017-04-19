//
//  Web_Handler.swift
//  GooTask
//
//  Created by mohamed hassan on 4/14/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

public class Web_Handler {
    
    
    class func getFullData(userName : String  , userPassword : String ) ->(String , [NSDictionary]) {
       
        var status : String = ""
        var data : [NSDictionary] = [NSDictionary]()
        
        
        
        let parameters: Parameters = ["name": userName , "password" : userPassword , "un":"userName", "up":"userPassword"]
        
        
        Alamofire.request("http://qtech-system.com/interview/index.php/apis/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            // convert response to json object
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: [])
            
            // get response status and message from the json object
            let result = json as! NSDictionary
            print("_________\(result["status"]!)")

            // convert data to array of dictionaries
            let mes = result["message"]! as! [NSDictionary]
            print("_________\(mes[0]["TransferID"]!)")
            print("First row _________\(mes[0])")
            
            
            
            status = result["status"]! as! String
            data = result["message"]! as! [NSDictionary]
        
        }
        return (status , data)
        }
        
        

    
    
}
