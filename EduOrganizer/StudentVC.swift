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
    
    func notesOn(notification: NSNotification){
        println("observer funfou");
        var selectedIndex = tabBarController!.selectedIndex;
        
        if (selectedIndex == 2){
            performSegueWithIdentifier("addNote", sender: nil);
        }
    }
    
    func refresh(notification: NSNotification){
        viewWillAppear(false);
    }
    
    //Carregamentos unicos
    override func viewDidLoad() {
      
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notesOn:", name:"notesNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh:", name:"addedNote", object: nil)
     
        studentView = StudentView(view: view, parent: self);
        studentView.horTableProfessor.delegate = self;
        
        
        //SECTIONS
        studentView.sectionSubjects.addTarget(self,
            action: "sectionTouched:",
            forControlEvents: UIControlEvents.TouchUpInside);
        studentView.sectionTeacher.addTarget(self,
            action: "sectionTouched:",
            forControlEvents: UIControlEvents.TouchUpInside);
        studentView.sectionNotes.addTarget(self,
            action: "sectionTouched:",
            forControlEvents: UIControlEvents.TouchUpInside);
        
        
    }
    
    //Recarrega da plist sempre que aparece
    override func viewWillAppear(animated: Bool) {
        studentView.subjOptions.labelOne.text = "";
        studentView.subjOptions.labelTwo.text = "";
        studentView.subjOptions.labelThree.text = "";
        
        studentView.notesOptions.labelOne.text = "";
        studentView.notesOptions.labelTwo.text = "";
        
        //ITENS SUBJECTS SECTION
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as! Array<ProfessorModel>;
        
        var subjectsDAO = SubjectDAO();
        materias = subjectsDAO.getDataArray() as! Array<SubjectModel>;
        
        if (materias.count > 0){
            studentView.subjOptions.labelOne.text = materias[0].nome + " - " + materias[0].id;
            studentView.subjOptions.sectionOne.addTarget(self,
                action: "subjectsTouched:",
                forControlEvents: UIControlEvents.TouchUpInside);
            
            if (materias.count > 1){
                studentView.subjOptions.labelTwo.text = materias[1].nome + " - " + materias[1].id;
                studentView.subjOptions.sectionTwo.addTarget(self,
                    action: "subjectsTouched:",
                    forControlEvents: UIControlEvents.TouchUpInside);
                
                if (materias.count > 2){
                    studentView.subjOptions.labelThree.text = materias[2].nome + " - " + materias[2].id;
                    studentView.subjOptions.sectionThree.addTarget(self,
                        action: "subjectsTouched:",
                        forControlEvents: UIControlEvents.TouchUpInside);
                }
            }
        }
        
        //ITENS NOTES SECTION
        var notesDAO = NoteDAO();
        notes = notesDAO.getDataArray() as! Array<NoteModel>;
        
        if (notes.count > 0){
            studentView.notesOptions.labelOne.text = notes[0].nome;
            studentView.notesOptions.sectionOne.addTarget(self,
                action: "notesTouched:",
                forControlEvents: UIControlEvents.TouchUpInside);
            
            if (notes.count > 1){
                studentView.notesOptions.labelTwo.text = notes[1].nome;
                studentView.notesOptions.sectionTwo.addTarget(self,
                    action: "notesTouched:",
                    forControlEvents: UIControlEvents.TouchUpInside);
            }
        }
        
        studentView.horTableProfessor.reloadInputViews();
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
            action: "teacherTouched:",
            forControlEvents: UIControlEvents.TouchUpInside);
        
        
        if let image = professor.imagem {
            professorCell.btnCell.setImage(UIImage(contentsOfFile:professor.imagem), forState: UIControlState.Normal);
            
        }else{
            professorCell.label.text = String.getAbrevName(professor.nome);
        }
        
        return professorCell;
    
    }
    
    func sectionTouched(sender:UIButton){
        if (sender.tag == 0){//subjects
            performSegueWithIdentifier("subjects", sender: nil);
        }else if (sender.tag == 1){//professors
            performSegueWithIdentifier("professors", sender: nil);
        }else if (sender.tag == 2){
            //segueToNotesList();
            performSegueWithIdentifier("notes", sender: nil);
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
    
    func notesTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("editNote", sender: nil);
    }
    
    func segueToNotesList(){
        let vc = NotesListVC(nibName:"NotesListVC", bundle:NSBundle.mainBundle())
        vc.notes = notes;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "infoSubject"){
            let destinationVC = segue.destinationViewController as? SubjectInfoVC;
            destinationVC?.subject = materias[selectedIndex];
        }
        else if(segue.identifier == "infoProfessor"){
            let destinationVC = segue.destinationViewController as? ProfessorInfoVC;
            destinationVC?.professor = professores[selectedIndex];
        }
        else if(segue.identifier == "editNote"){
            let destinationVC = segue.destinationViewController as? AddNotesVC;
            destinationVC?.note = notes[selectedIndex];
        }
        else if(segue.identifier == "addNote"){
            //let destinationVC = segue.destinationViewController as? AddNotesVC;
            //destinationVC?.hidesBottomBarWhenPushed=true;
            //(destinationVC?.tabBarController as FirstVC).firstView.fancyTabBar.hidden=true;
    
        }

    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return view.frame.width/2.5;
    }
}