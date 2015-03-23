//
//  SchoolScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/13/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class StudentVC: UIViewController, TableViewDelegate{

    var professores : Array<ProfessorModel> = Array<ProfessorModel>();
    var materias: Array<SubjectModel> = Array<SubjectModel>();
    
    var studentView : StudentView!;
    var selectedIndex:Int = Int();
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        
        studentView = StudentView(frame: view.frame, parent: self);
        studentView.horTableProfessor.delegate = self;
        studentView.horTableSubjects.delegate = self;
        view = studentView;
        
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as Array<ProfessorModel>;
        
        var subjectsDAO = SubjectDAO();
        materias = subjectsDAO.getDataArray() as Array<SubjectModel>;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        
        if (horizontalTableView == studentView.horTableProfessor){
            return professores.count;
        }else{
            return materias.count;
        }

    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        if (horizontalTableView == studentView.horTableProfessor){
            
            var professorCell : StudentCell = StudentCell(view: view);
            var professor : ProfessorModel = professores[cellForRowAtIndexPath.row] as ProfessorModel;

            professorCell.btnCell.tag = cellForRowAtIndexPath.row;
            professorCell.btnCell.addTarget(self,
                                            action: "teacherTouched:",
                                            forControlEvents: UIControlEvents.TouchUpInside);
            
            
            if let image = professor.imagem {
                professorCell.btnCell.setImage(professor.imagem, forState: UIControlState.Normal);

            }else{
                professorCell.label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
                professorCell.label.text = String.getAbrevName(professor.nome);
            }
            
            return professorCell;
            
        }else{
            
            var subjectCell : StudentCell = StudentCell(view: view);
            var subject : SubjectModel = materias[cellForRowAtIndexPath.row] as SubjectModel;
            
            subjectCell.label.text = String(format: "%@\n(%@)",
                                            (subject.nome),
                                            (subject.id));
            
            subjectCell.btnCell.tag = cellForRowAtIndexPath.row;
            subjectCell.btnCell.addTarget(self,
                                          action: "subjectsTouched:",
                                          forControlEvents: UIControlEvents.TouchUpInside);
            

            return subjectCell;
        }

    }

    func subjectsTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("infoSubject", sender: nil);
    }
    
    func teacherTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("infoProfessor", sender: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "infoSubject"){
            let destinationVC = segue.destinationViewController as? SubjectInfoVC;
            destinationVC?.subject = materias[selectedIndex];
        }else{
            let destinationVC = segue.destinationViewController as? ProfessorInfoVC;
            destinationVC?.professor = professores[selectedIndex];
        }

    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return view.frame.width/2.5;
    }
}