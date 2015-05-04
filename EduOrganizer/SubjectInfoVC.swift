//
//  subjectInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/18/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SubjectInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var subject: SubjectModel = SubjectModel();
    var deleteItem: UIBarButtonItem!;
    var deleteAlert : UIAlertController!;
    var okItem : UIBarButtonItem!;
    var subjectInfoView : InfoGenericView!;
    
    var adit:CGFloat!;
  

    override func viewDidLoad() {
        
        subjectInfoView = InfoGenericView(view: view, parent: self);
        subjectInfoView.tableView.delegate = self;
        subjectInfoView.tableView.dataSource = self;
        
        subjectInfoView.label.text = subject.nome;
        
        title = subject.id;
        
        deleteItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteSubjectAlert");
        navigationItem.rightBarButtonItem = deleteItem;
        
        deleteAlert = UIAlertController(title: "Confirm deletion",
            message: "Delete subject " + title! + "?",
            preferredStyle: .ActionSheet);
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        let okAction:UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteSubject);
        deleteAlert.addAction(cancelAction);
        deleteAlert.addAction(okAction);
        
        okItem = UIBarButtonItem(title: "OK",style: .Plain,target: self,action: "dismissKB");
        
    }
    
    func dismissKB(){
        self.view.endEditing(true);
        navigationItem.rightBarButtonItem = deleteItem;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        navigationItem.rightBarButtonItem = okItem;
    }
    func deleteSubjectAlert(){
        presentViewController(deleteAlert, animated: true, completion: nil);
    }

    
    func deleteSubject(alert: UIAlertAction!){
       SubjectDAO().deleteDataById(subject.id);
        navigationController?.popViewControllerAnimated(true);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var rows = 1;
        
        if (subject.tarefas != nil && subject.tarefas.count > 0){
            rows++;
        }
        
        if (subject.notes != nil && subject.notes.count > 0){
            rows++;
        }
        
        return rows;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/8.0;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header : InfoCellGeneric = InfoCellGeneric(view: view);
        header.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        header.label.userInteractionEnabled = false;
        header.label.font = UIFont(name: "AvenirNext-Bold", size: 20);
        if(section==0){
            header.label.text = "About";
        }
        else if(section == 1){
            if (subject.tarefas.count > 0){
                header.label.text = "Tasks";
            }else{
                header.label.text = "Notes";
            }
        }
        else if(section == 2){
            header.label.text = "Notes";
        }
        return header;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 3;
        }else if(section == 1){
            
            if (subject.tarefas.count > 0){
                return subject.tarefas.count;
            }else{
                return subject.notes.count;
            }
            
        }else {
            return subject.notes.count;
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/8.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var subjectInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        subjectInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        subjectInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
        subjectInfoCell.label.delegate = self;
        
        if(indexPath.section == 0){ // secao 0
            
            switch (indexPath.row){
                case 0: subjectInfoCell.label.text = subject.id;
                case 1: subjectInfoCell.label.text = subject.nome;
                case 2:
                    
                    if (subject.professor != nil){
                        subjectInfoCell.label.text = subject.professor.nome;
                    }
                
                default : subjectInfoCell.label.text = "error";
            }
            
        }else if(indexPath.section == 1){// secao 1
            
            if (subject.tarefas.count > 0){
                subjectInfoCell.label.text = "tasks";
            }
            else{
                subjectInfoCell.label.text = (subject.notes[indexPath.row] as NoteModel).nome;
            }
            
        } else if (indexPath.section == 2){// secao 2
            
            subjectInfoCell.label.text = (subject.notes[indexPath.row] as NoteModel).nome;
            
        }
        
        return subjectInfoCell;

    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
    }
    
    func keyboardShow(notification: NSNotification){
        let addition = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height;
        adit = self.subjectInfoView.tableView.frame.origin.y;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.subjectInfoView.tableView.frame = CGRectMake(self.subjectInfoView.tableView.frame.origin.x, self.subjectInfoView.tableView.frame.origin.y-self.adit, self.subjectInfoView.tableView.frame.width, self.subjectInfoView.tableView.frame.height);
            }, completion: nil);
    }
    
    func keyboardHide(notification: NSNotification){
        let addition = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size.height;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.subjectInfoView.tableView.frame = CGRectMake(self.subjectInfoView.tableView.frame.origin.x, self.subjectInfoView.tableView.frame.origin.y+self.adit, self.subjectInfoView.tableView.frame.width, self.subjectInfoView.tableView.frame.height);
            }, completion: nil);
        
    }
}