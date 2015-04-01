//
//  AddProfessor.swift
//  Stud
//
//  Created by Pietro Ribeiro Pepe on 3/31/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddProfessorVC : UIViewController {
    
    var professor: ProfessorModel = ProfessorModel();
    
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        var area:CGRect = CGRectMake(view.frame.width*0.2, view.frame.height*0.3, view.frame.width*0.6, view.frame.height*0.4);
        var name:UITextField = UITextField(frame: area);
        name.text = "teste";
        name.backgroundColor = UIColor.blueColor();
        view.addSubview(name);
        
    }
}