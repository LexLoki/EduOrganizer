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
    
    var note : NoteModel = NoteModel();
    var noteDAO : NoteDAO = NoteDAO();
    
    var shouldSave:Bool = false;
    var noteView : AddNoteView!;
    var deleteAlert : UIAlertController!;
    
    var saveItem : UIBarButtonItem!;
    var okItem : UIBarButtonItem!;
    var deleteItem : UIBarButtonItem!;
    
    override func viewDidLoad() {
        
        var tabBar = tabBarController as FirstVC;
        tabBar.firstView.fancyTabBar.hidden=true;
        tabBar.tabBar.hidden=true;
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        noteView = AddNoteView(view: view, parent: self);
        noteView.text?.delegate = self;
        
        okItem = UIBarButtonItem(title: "OK",style: .Plain,target: self,action: "dismissKB");
        
        if (note.id != nil) {
            
            title = note.nome;
            noteView.text.text = note.texto;
            
            deleteItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteNoteAlert");
            navigationItem.rightBarButtonItem = deleteItem;
            
            
        }else{
            
            title = "New Note";
            
            saveItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "save");
            navigationItem.rightBarButtonItem = saveItem;
            
        }
        
        deleteAlert = UIAlertController(title: "Confirm deletion",
            message: "Delete note " + title! + "?",
            preferredStyle: .ActionSheet);
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        let okAction:UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteNote);
        deleteAlert.addAction(cancelAction);
        deleteAlert.addAction(okAction);
    }
    
    func deleteNoteAlert(){
        presentViewController(deleteAlert, animated: true, completion: nil);
    }
    
    
    func deleteNote(alert: UIAlertAction!){
        noteDAO.deleteDataById(note.id);
        shouldSave=false;
        navigationController?.popViewControllerAnimated(true);
    }
    
    func dismissKB(){
        noteView.text.resignFirstResponder();
        if(note.id != nil){
            navigationItem.rightBarButtonItem = deleteItem;
        }else{
            navigationItem.rightBarButtonItem = saveItem;
        }
    }
    
    func save(){
        shouldSave = true;
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
        if(note.id != nil){
            shouldSave = true;
        }
        navigationItem.rightBarButtonItem = okItem;
        println("editou");
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(shouldSave==true){
            saveAction();
        }
        var tabBar = tabBarController as FirstVC;
        tabBar.firstView.fancyTabBar.hidden=false;
        tabBar.tabBar.hidden=false;
    }
    
}