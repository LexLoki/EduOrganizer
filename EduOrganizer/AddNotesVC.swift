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
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardShown:" , name: UIKeyboardDidShowNotification, object: nil);
        //NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardHide:" , name: UIKeyboardDidHideNotification, object: nil);
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        
        var tabBar = tabBarController as FirstVC;
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
    
    func textViewDidEndEditing(textView: UITextView) {
        println("terminou");
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(shouldSave==true){
            saveAction();
        }
        var tabBar = tabBarController as FirstVC;
        tabBar.firstView.fancyTabBar.hidden=false;
        tabBar.tabBar.hidden=false;
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
    }
    
    func keyboardShown(aNotification:NSNotification){
        var userInfo:NSDictionary = aNotification.userInfo!;
        let keyboardInfoFrame:CGRect = (userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey) as NSValue).CGRectValue();
        
        let windowFrame:CGRect = (view.window?.convertRect(view.frame, fromView: view))!;
        let keyboardFrame:CGRect = CGRectIntersection(windowFrame, keyboardInfoFrame);
        let coveredFrame:CGRect = (view.window?.convertRect(keyboardFrame, toView: view))!;
        
        let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, coveredFrame.size.height, 0.0);
        noteView.text.contentInset = contentInsets;
        noteView.text.scrollIndicatorInsets = contentInsets;
        
        //noteView.text.scrollRectToVisible(noteView.text, animated: true);
    }
    
    /*
    CGRect keyboardInfoFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // get the height of the keyboard by taking into account the orientation of the device too
    CGRect windowFrame = [self.view.window convertRect:self.view.frame fromView:self.view];
    CGRect keyboardFrame = CGRectIntersection (windowFrame, keyboardInfoFrame);
    CGRect coveredFrame = [self.view.window convertRect:keyboardFrame toView:self.view];
    
    // add the keyboard height to the content insets so that the scrollview can be scrolled
    UIEdgeInsets contentInsets = UIEdgeInsetsMake (0.0, 0.0, coveredFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // make sure the scrollview content size width and height are greater than 0
    [self.scrollView setContentSize:CGSizeMake (self.scrollView.width, self.scrollView.contentSize.height)];
    
    // scroll to the text view
    [self.scrollView scrollRectToVisible:self.activeTextView.superview.frame animated:YES];
    */
    
    func keyboardHide(){
    }
}