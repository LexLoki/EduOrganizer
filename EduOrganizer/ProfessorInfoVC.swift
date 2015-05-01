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
    
    override func viewWillAppear(animated: Bool) {
        professor.materias = SubjectDAO().getSubjectsByIdProfessor(professor.id);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var professorInfoView : InfoGenericView = InfoGenericView(view: view, parent: self);
        professorInfoView.tableView.delegate = self;
        professorInfoView.tableView.dataSource = self;
        
        if let image = professor.imagem {
            professorInfoView.imageView.image = UIImage(contentsOfFile:professor.imagem);
        }else{
            professorInfoView.label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
            professorInfoView.label.text = String.getAbrevName(professor.nome);
        }
        
        title = professor.nome;
        
    }
    
    func editMode(){
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(section == 0){
            return 3;
        }
        
        return professor.materias.count;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/10;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header : InfoCellGeneric = InfoCellGeneric(view: view);
        header.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        header.label.font = UIFont(name: "AvenirNext-Bold", size: 20);
        if(section==0){
            header.label.text = "Bio";
        }
        else{
            header.label.text = "Teachs";
        }
        return header;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/10;
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var professorInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        professorInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        professorInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
        
        if(indexPath.section == 0){  // secao 0 row>0
            
            switch (indexPath.row){
                case 0: professorInfoCell.label.text = professor.nome;
                case 1: professorInfoCell.label.text = professor.email;
                case 2: professorInfoCell.label.text = professor.telefone;
                default : professorInfoCell.label.text = "error";
            }
            
        }else{
            
            var subjectStr = (professor.materias[indexPath.row] as SubjectModel).id + " / " +
                             (professor.materias[indexPath.row] as SubjectModel).nome;
            
            professorInfoCell.label.text = subjectStr;
        }
        
        return professorInfoCell;
    }
}