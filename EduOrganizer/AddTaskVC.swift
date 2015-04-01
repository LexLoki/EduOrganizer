//
//  AddTask.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/1/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddTaskVC : UIViewController {
    
    var tarefas: TaskModel = TaskModel();
    
    override func viewDidLoad(){
        var area:CGRect = CGRectMake(view.frame.width*0.2, view.frame.height*0.3, view.frame.width*0.6, view.frame.height*0.4);
        var name:UITextField = UITextField(frame: area);
        name.text = "tarefas";
        name.backgroundColor = UIColor.redColor();
        view.addSubview(name);
        
      
    }
    
    
}