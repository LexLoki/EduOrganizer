//
//  StudNavigationController.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/27/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class StudNC : UINavigationController {
    
    override func viewDidLoad() {
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        
        navigationBar.titleTextAttributes = attributes;
        
    }
   
}