//
//  BlocoNotas.swift
//  EduOrganizer
//
//  Created by Juliana Zilberberg on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit


class AddNotesVC: UIViewController{
    
    var text: UITextField?;
    
    override func viewDidLoad() {
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 18)!, NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)];
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        self.title = "New Note";
        view.backgroundColor = UIColorFromRGB(0x1E3044)
        var tela: CGRect = CGRect(x: self.view.frame.size.width*0.03,y: self.view.frame.size.height*0.03,  width: self.view.frame.size.width*0.94, height: self.view.frame.size.height*0.82);
        
        
        text = UITextField(frame: tela)
        text?.textColor = UIColorFromRGB(0xFFFFFF)
        text?.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;//posicao do cursor//
        text?.font = UIFont (name: "Avenir Next", size: 20)
        self.view.addSubview(text!) //aparecer o textField na tela//
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "saveToPlist")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",style: .Plain,target: self, action: "segueBoladao")

    }
    
    func segueBoladao(){
       self.performSegueWithIdentifier("segueTasks", sender: nil)
    }
    

    func saveToPlist(){
        var pathAux:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var path: String = pathAux.stringByAppendingPathComponent("userData.plist" as String);
        var contents:NSMutableDictionary = NSDictionary(contentsOfFile: path)?.mutableCopy() as NSMutableDictionary;
        
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))}
}