//
//  BlocoNotas.swift
//  EduOrganizer
//
//  Created by Juliana Zilberberg on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit


class BlocoNotas : UIViewController{
    
//declaracao do textfield sem valor(optional)//
    var text: UITextField?;
    var tittle: UITextField?;
    override func viewDidLoad() {
        var tela: CGRect = CGRect(x: self.view.frame.size.width*0.1 ,y: self.view.frame.size.height*0.2,  width: self.view.frame.size.width*0.8, height: self.view.frame.size.height*0.7);
        
        text = UITextField(frame: tela)
        text?.borderStyle=UITextBorderStyle.RoundedRect; //borda arredondada//
        text?.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;//posicao do cursor//
        self.view.addSubview(text!) //aparecer o textField na tela//
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",style: .Plain,target: self,action: "saveToPlist")
        //criando titulo notas//
        var titulo: CGRect = CGRect(x: self.view.frame.size.width*0.1 ,y: self.view.frame.size.height*0.1,  width: self.view.frame.size.width*0.8, height: self.view.frame.size.height*0.07);
        
        tittle = UITextField(frame: titulo)
        tittle?.borderStyle=UITextBorderStyle.RoundedRect; //borda arredondada//
        tittle?.contentVerticalAlignment = UIControlContentVerticalAlignment.Top;//posicao do cursor//
        self.view.addSubview(tittle!) //aparecer o textField na tela//


    }

    
    func saveToPlist(){
        var pathAux:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        var path: String = pathAux.stringByAppendingPathComponent("userData.plist" as String);
        var contents:NSMutableDictionary = NSDictionary(contentsOfFile: path)?.mutableCopy() as NSMutableDictionary;
        //var note:NSDictionary = NSDictionary(objects: [tittle?.text,text?.text], forKeys: ["nome","texto"]) as NSDictionary;
        //var anotacoes:NSMutableDictionary = contents["anotacoes"] as NSDictionary;
        
    }
}