//
//  BlocoNotas.swift
//  EduOrganizer
//
//  Created by Juliana Zilberberg on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit


class AddNotesVC: UIViewController, UITextViewDelegate, UIAlertViewDelegate{

    var note : NoteModel = NoteModel();
    var noteDAO : NoteDAO = NoteDAO();
    
    var noteView : AddNoteView!;
    var textToLoad : String!;
    var segueDone : String!;
    var deleteAlert : UIAlertView!;
    
    override func viewDidLoad() {
        
        noteView = AddNoteView(view: view, parent: self);
        noteView.text?.delegate = self;
        
        if (note.id != nil) {
            
            title = note.nome;
            noteView.text.text = note.texto;
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteNoteAlert")

        }else{
            
            title = "New Note";
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "save");
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",style: .Plain,target: self, action: "back");
        }
        
        deleteAlert = UIAlertView(title: "Confirm deletion",
            message: "Delete note " + title! + "?",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Delete");
        
    }
    
    func deleteNoteAlert(){
        deleteAlert.show();
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1){
            deleteNote();
            back();
        }
    }
    
    func back(){
       performSegueWithIdentifier("segueTasks", sender: nil)
    }
    
    func deleteNote(){
        noteDAO.deleteDataById(note.id);
    }
    
    func save(){
        
        var noteModel : NoteModel = NoteModel();

        if ((noteView.text!.text as NSString).length > 10){
            noteModel.nome = (noteView.text!.text as NSString).substringToIndex(10);
        }else{
            noteModel.nome = (noteView.text!.text as NSString);
        }
        
        noteModel.texto = noteView.text!.text as String;
        noteModel.data = NSDate();
        
        noteDAO.saveData(noteModel);
        back();
    }

}