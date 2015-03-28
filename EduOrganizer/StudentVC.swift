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
    var notes : Array<NoteModel> = Array<NoteModel>();
    
    var studentView : StudentView!;
    var selectedIndex:Int = Int();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        
        studentView = StudentView(view: view, parent: self);
        studentView.horTableProfessor.delegate = self;
        
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as Array<ProfessorModel>;
        
        var subjectsDAO = SubjectDAO();
        materias = subjectsDAO.getDataArray() as Array<SubjectModel>;
        
        var notesDAO = NoteDAO();
        notes = notesDAO.getDataArray() as Array<NoteModel>;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        
        return professores.count;

    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var professorCell : StudentCell = StudentCell(view: view);
        var professor : ProfessorModel = professores[cellForRowAtIndexPath.row] as ProfessorModel;
        
        professorCell.btnCell.tag = cellForRowAtIndexPath.row;
        professorCell.btnCell.addTarget(self,
            action: "notesTouched:",
            forControlEvents: UIControlEvents.TouchUpInside);
        
        
        if let image = professor.imagem {
            professorCell.btnCell.setImage(professor.imagem, forState: UIControlState.Normal);
            
        }else{
            professorCell.label.text = String.getAbrevName(professor.nome);
        }
        
        return professorCell;
    
    }

    func subjectsTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("infoSubject", sender: nil);
    }
    
    func teacherTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("infoProfessor", sender: nil);
    }
    
    func notesTouched(sender:UIButton){
        let vc = NotesListVC(nibName:"NotesListVC", bundle:NSBundle.mainBundle())
        vc.notes = notes;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "infoSubject"){
            let destinationVC = segue.destinationViewController as? SubjectInfoVC;
            destinationVC?.subject = materias[selectedIndex];
        }else if(segue.identifier == "infoProfessor"){
            let destinationVC = segue.destinationViewController as? ProfessorInfoVC;
            destinationVC?.professor = professores[selectedIndex];
        }else{
            let destinationVC = segue.destinationViewController as? NotesListVC;
            destinationVC?.notes = notes;
        }

    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return view.frame.width/2.5;
    }
}