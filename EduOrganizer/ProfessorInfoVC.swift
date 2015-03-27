//
//  ProfessorInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/19/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class ProfessorInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var professor: ProfessorModel = ProfessorModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var professorInfoView : InfoGenericView = InfoGenericView(view: view, parent: self);
        professorInfoView.tableView.delegate = self;
        professorInfoView.tableView.dataSource = self;
        
        if let image = professor.imagem {
            professorInfoView.imageView.image = professor.imagem;
        }else{
            professorInfoView.label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
            professorInfoView.label.text = String.getAbrevName(professor.nome);
        }
    
        title = professor.nome;
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(section == 0){
            return 4;
        }
        
        return 3;//professor.materias.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/10;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var professorInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        if(indexPath.row == 0){
            
            professorInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
            professorInfoCell.label.font = UIFont(name: "AvenirNext-Bold", size: 20);
            
            if(indexPath.section == 0){
                professorInfoCell.label.text = "Bio";
            }else{
                professorInfoCell.label.text = "Teachs";
            }
            
        }else{
            professorInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
            professorInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
            
            if(indexPath.section == 0){  // secao 0 row>0
                
                switch (indexPath.row){
                    case 1: professorInfoCell.label.text = professor.nome;
                    case 2: professorInfoCell.label.text = professor.email;
                    case 3: professorInfoCell.label.text = professor.telefone;
                    default : professorInfoCell.label.text = "error";
                }
                
            }else{  //secao 1 row>0
                
                professorInfoCell.label.text = "materia";//professor.materias[indexPath.row-1];
            }
        }
        
        return professorInfoCell;
    }
}