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
    
    var editMode = false;
    var shouldSave:Bool = false;
    var noteView : AddNoteView!;
    var textToLoad : String!;
    var segueDone : String!;
    var deleteAlert : UIAlertController!;
    
    var saveItem : UIBarButtonItem!;
    var okItem : UIBarButtonItem!;
    var deleteItem : UIBarButtonItem!;
    
    override func viewDidLoad() {
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        
        var tabBar = tabBarController as! FirstVC;
        tabBar.firstView.fancyTabBar.hidden=true;
        tabBar.tabBar.hidden=true;
        
        noteView = AddNoteView(view: view, parent: self);
        noteView.text?.delegate = self;
        
        
        okItem = UIBarButtonItem(title: "OK",style: .Plain,target: self,action: "dismissKB");
        
        if (note.id != nil) {
            
            editMode = true;
            title = note.nome;
            noteView.text.text = note.texto;
            
            deleteItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteNoteAlert");
            navigationItem.rightBarButtonItem = deleteItem;
            
            
        }else{
            
            title = "New Note";
            
            saveItem = UIBarButtonItem(title: "Save",style: .Plain,target: self,action: "save");
            navigationItem.rightBarButtonItem = saveItem
            
        }
        
        //        deleteAlert = UIAlertView(title: "Confirm deletion",
        //            message: "Delete note " + title! + "?",
        //            delegate: self,
        //            cancelButtonTitle: "Cancel",
        //            otherButtonTitles: "Delete");
        //deleteAlert = UIAlertController(title
        
        deleteAlert = UIAlertController(title: "Confirm deletion",
            message: "Delete note " + title! + "?",
            preferredStyle: .ActionSheet);
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        let okAction:UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteNote);
        deleteAlert.addAction(cancelAction);
        deleteAlert.addAction(okAction);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardShow:" , name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardHide:" , name: UIKeyboardWillHideNotification, object: nil);
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
            note.nome = (noteView.text!.text as String);
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
        print("editou");
    }
    
    
    func textViewDidEndEditing(textView: UITextView) {
        print("terminou");
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(shouldSave==true){
            saveAction();
        }
        var tabBar = tabBarController as! FirstVC;
        tabBar.firstView.fancyTabBar.hidden=false;
        tabBar.tabBar.hidden=false;
        
        NSNotificationCenter.defaultCenter().removeObserver(self);
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
    }
    
    
    func keyboardShow(notification: NSNotification){
        var insets:UIEdgeInsets = noteView.text.contentInset;
        let addition = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height;
        insets.bottom += addition;
        noteView.text.contentInset = insets;
        
        insets = noteView.text.scrollIndicatorInsets;
        insets.bottom += addition;
        noteView.text.scrollIndicatorInsets = insets;
    
    }
    
    func keyboardHide(notification: NSNotification){
        var insets:UIEdgeInsets = noteView.text.contentInset;
        let addition = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size.height;
        insets.bottom -= addition;
        noteView.text.contentInset = insets;
        
        insets = noteView.text.scrollIndicatorInsets;
        insets.bottom -= addition;
        noteView.text.scrollIndicatorInsets = insets;
    }
    
    
    /*
    - (void)_keyboardWillShowNotification:(NSNotification*)notification
    {
    UIEdgeInsets insets = self.textView.contentInset;
    insets.bottom += [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.textView.contentInset = insets;
    
    insets = self.textView.scrollIndicatorInsets;
    insets.bottom += [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.textView.scrollIndicatorInsets = insets;
    }
    
    - (void)_keyboardWillHideNotification:(NSNotification*)notification
    {
    UIEdgeInsets insets = self.textView.contentInset;
    insets.bottom -= [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    self.textView.contentInset = insets;
    
    insets = self.textView.scrollIndicatorInsets;
    insets.bottom -= [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
    self.textView.scrollIndicatorInsets = insets;
    }
    */
    
}