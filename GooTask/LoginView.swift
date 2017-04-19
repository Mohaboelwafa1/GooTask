//
//  ViewController.swift
//  GooTask
//
//  Created by mohamed hassan on 4/11/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire



class LoginView: UIViewController {

    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set border color , width and radius to the text fields
        
        self.userNameTxt.layer.borderColor = UIColor.orange.cgColor
        self.passWordTxt.layer.borderColor = UIColor.orange.cgColor
        
        self.userNameTxt.layer.borderWidth = 1.5
        self.passWordTxt.layer.borderWidth = 1.5
        
        self.userNameTxt.layer.cornerRadius = 5
        self.passWordTxt.layer.cornerRadius = 5
        
        // set border radius to the login button
        self.loginButton.layer.cornerRadius = 5
        
        
        
        
        
        
    }
    
    
    @IBAction func LoginFunction(_ sender: Any) {
        
        // fetching data from server by http request using alamofire

        // check availability onf internet connection
        if Reachability.isConnectedToNetwork() == false {
            
            // if there is no internet connection
            let alert = UIAlertView(title: "Error", message: "Please make sure of your internet connection", delegate: nil, cancelButtonTitle: "OK")
            alert.alertViewStyle = .default
            alert.show()
            return
            
        }
        

        
        // paramaters that will be sent to the server
        let parameters: Parameters = ["name": "test" , "password" : "123" , "un":"userName", "up":"userPassword"]
        
        
        // http post request
        Alamofire.request("http://qtech-system.com/interview/index.php/apis/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            
            // convert response to json object
            let json = try! JSONSerialization.jsonObject(with: response.data!, options: [])
            
            // get response status from the json object
            let status = json as! NSDictionary
            
            // get the data from the object
            let message = json as! NSDictionary
            
            // convert data to array of dictionaries
            let data = message["message"]! as! [NSDictionary]
            
            self.defaults.setValue(data, forKey: "cashedData")
            
            if (status["status"]! as! String == "success") {

                // open Main page
                let container :ContainerView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerView") as! ContainerView
                
                self.present(container, animated: false, completion: nil)
                

            }
            
        }
        
       

    }
    



}

