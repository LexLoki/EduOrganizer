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
    var notesCount = 0;
    
    override func viewDidLoad() {
        
        var subjectInfoView : InfoGenericView = InfoGenericView(view: view, parent: self);
        subjectInfoView.tableView.delegate = self;
        subjectInfoView.tableView.dataSource = self;
        
        subjectInfoView.label.text = subject.nome;
        
        title = subject.id;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var rows = 1;
        
        if (subject.tarefas.count > 0){
            rows++;
        }
        
        if (subject.notes.count > 0){
            rows++;
        }
        
        return rows;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 4;
        }else if(section == 1){
            
            if (subject.tarefas.count > 0){
                return subject.tarefas.count + 1;
            }else{
                return subject.notes.count + 1;
            }
            
        }else {
            return subject.notes.count + 1;
        }
        
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
            }else if(indexPath.section == 1){
                if (subject.tarefas.count > 0){
                    subjectInfoCell.label.text = "Tasks";
                }else{
                    subjectInfoCell.label.text = "Notes";
                }
            }else if(indexPath.section == 2){
                subjectInfoCell.label.text = "Notes";
            }
            
        }else{
            subjectInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
            subjectInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
            
            if(indexPath.section == 0){ // secao 0
                
                switch (indexPath.row){
                    case 1: subjectInfoCell.label.text = subject.id;
                    case 2: subjectInfoCell.label.text = subject.nome;
                    case 3:
                        
                        if (subject.professor != nil){
                            subjectInfoCell.label.text = subject.professor.nome;
                        }
                    
                    default : subjectInfoCell.label.text = "error";
                }
                
            }else if(indexPath.section == 1){// secao 1
                
                if (subject.tarefas.count > 0){
                    subjectInfoCell.label.text = "tasks";
                }else{
                    
                    if (notesCount >= subject.notes.count){
                        notesCount = 0;
                    }
                    
                    subjectInfoCell.label.text = (subject.notes[notesCount] as NoteModel).nome;
                    notesCount++;
                }
                
            } else if (indexPath.section == 2){// secao 2
                
                if (notesCount >= subject.notes.count){
                    notesCount = 0;
                }
                
                subjectInfoCell.label.text = (subject.notes[notesCount] as NoteModel).nome;
                notesCount++;
                
            }
        }
        
        return subjectInfoCell;

    }
}