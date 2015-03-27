//
//  subjectInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/18/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SubjectInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var subject: SubjectModel = SubjectModel();
    
    override func viewDidLoad() {
        
        var subjectInfoView : InfoGenericView = InfoGenericView(view: view, parent: self);
        subjectInfoView.tableView.delegate = self;
        subjectInfoView.tableView.dataSource = self;
        
        subjectInfoView.label.text = subject.nome;
        
        title = subject.id;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 4;
        }
        
        return 3;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/8.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var subjectInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        if(indexPath.row == 0){
            
            subjectInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
            subjectInfoCell.label.font = UIFont(name: "AvenirNext-Bold", size: 20);
            
            if(indexPath.section == 0){
                subjectInfoCell.label.text = "About";
            }else{
                subjectInfoCell.label.text = "Tasks";
            }
            
        }else{
            subjectInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
            subjectInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
            
            if(indexPath.section == 0){  // secao 0 row>0
                
                switch (indexPath.row){
                    case 1: subjectInfoCell.label.text = subject.id;
                    case 2: subjectInfoCell.label.text = subject.nome;
                    case 3:
                        
                        if (subject.professor != nil){
                            subjectInfoCell.label.text = subject.professor.nome;
                        }
                    
                    default : subjectInfoCell.label.text = "error";
                }
                
            }else{  //secao 1 row>0
                
                subjectInfoCell.label.text = "tasks";//professor.materias[indexPath.row-1];
            }
        }
        
        return subjectInfoCell;

    }
}