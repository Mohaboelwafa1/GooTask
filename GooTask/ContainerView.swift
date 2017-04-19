//
//  ContainerView.swift
//  GooTask
//
//  Created by mohamed hassan on 4/18/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit

class ContainerView: UIViewController {
    
    // outlet objectsfrom the storyboard
    @IBOutlet weak var changeViewButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    // flag to know if the current view is grid or list
    var isGridFlag = true
    
    
    // grid & list screens
    var gridScreen : GridView!
    var listScreen : ListView!
    
    
    // icons for button in charge of changing layout of the view
    let listImage = UIImage(named: "listMenu.png")
    let gridImage = UIImage(named: "gridMenu.png")
    
    
    override func viewDidLoad() {
        
        // first time will be grid view
        openView(isGrid: isGridFlag)
    }
    
    func openView(isGrid : Bool) {
        
        
        // if flag true then grid view will be loaded
        
        if (isGridFlag) {
            
            // If the user opened list screen we must remove it first
            if (listScreen != nil) {
                listScreen.view .removeFromSuperview()
            }
            
            
            
            gridScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GridView") as! GridView
            gridScreen.view.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
            self.mainView.addSubview(gridScreen.view)
            self.addChildViewController(gridScreen)
            
            // change button icon
            self.changeViewButton.setBackgroundImage(listImage, for: .normal)
            
            isGridFlag = false
            
        } else {
        
            if (gridScreen != nil) {
             gridScreen.view.removeFromSuperview()   
            }
            
            
        listScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListView") as! ListView
        listScreen.view.frame = CGRect(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height)
        self.mainView.addSubview(listScreen.view)
        self.addChildViewController(listScreen)
            
            self.changeViewButton.setBackgroundImage(gridImage, for: .normal)
            isGridFlag = true
        }
    }
    
    
    
    // change view layout function
    @IBAction func changeButtonFunction(_ sender: Any) {
        openView(isGrid: isGridFlag)
    }
}
