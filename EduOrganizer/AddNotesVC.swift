//
//  BlocoNotas.swift
//  EduOrganizer
//
//  Created by Juliana Zilberberg on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit


class AddNotesVC: UIViewController, UITextViewDelegate{

    var noteView : AddNoteView!;
    
    override func viewDidLoad() {
        
        noteView = AddNoteView(view: view, parent: self);
        noteView.text?.delegate = self;

        title = "New Note";
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "save");
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",style: .Plain,target: self, action: "back");

    }
    
    func back(){
       self.performSegueWithIdentifier("segueTasks", sender: nil)
    }
    
    func save(){
        
        var noteDAO : NoteDAO = NoteDAO();
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