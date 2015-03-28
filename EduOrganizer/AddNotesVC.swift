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
    
    var editMode = false;
    var shouldSave:Bool = false;
    var noteView : AddNoteView!;
    var textToLoad : String!;
    var segueDone : String!;
    var deleteAlert : UIAlertView!;
    
    override func viewDidLoad() {
        
        noteView = AddNoteView(view: view, parent: self);
        noteView.text?.delegate = self;
        
        if (note.id != nil) {
            
            editMode = true;
            title = note.nome;
            noteView.text.text = note.texto;
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteNoteAlert");
            

        }else{
    
            title = "New Note";
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "save");

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
            shouldSave=false;
            navigationController?.popViewControllerAnimated(true);
        }
    }
    
    func deleteNote(){
        noteDAO.deleteDataById(note.id);
    }
    
//    override func viewDidDisappear(animated: Bool) {
//        if (editMode){
//            save();
//        }
//    }
    
    func save(){
        navigationController?.popViewControllerAnimated(true);
    }
    
    func saveAction(){
        if ((noteView.text!.text as NSString).length == 0){
            note.nome = "Empty Note";
        }else if ((noteView.text!.text as NSString).length > 10){
            note.nome = (noteView.text!.text as NSString).substringToIndex(10);
        }else{
            note.nome = (noteView.text!.text as NSString);
        }
        
        note.texto = noteView.text!.text as String;
        note.data = NSDate();
        
        noteDAO.saveData(note);
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        shouldSave = true;
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(shouldSave==true){
            saveAction();
        }
    }

}