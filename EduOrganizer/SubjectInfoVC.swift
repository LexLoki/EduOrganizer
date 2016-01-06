//
//  subjectInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/18/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SubjectInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var subject: SubjectModel = SubjectModel();
    var deleteItem: UIBarButtonItem!;
    var deleteAlert : UIAlertController!;
    var okItem : UIBarButtonItem!;
    var cancelItem : UIBarButtonItem!;
    var subjectInfoView : InfoGenericView!;
    
    var adit:CGFloat!;
    
    private var professors : Array<ProfessorModel>!;
    private var professorText : UITextField!;
    private var nameText : UITextField!;
    private var codeText : UITextField!;
    
    private var wasEdited = false;

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
        
        okItem = UIBarButtonItem(title: "Save",style: .Done,target: self,action: "saveData");
        cancelItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissKB");
        
        professors = ProfessorDAO().getDataArray() as! Array<ProfessorModel>;
        
        adit = self.subjectInfoView.tableView.frame.origin.y;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardShow:" , name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardHide:" , name: UIKeyboardWillHideNotification, object: nil);
    }
    
    func dismissKB(){
        self.view.endEditing(true);
        navigationItem.rightBarButtonItem = deleteItem;
        navigationItem.leftBarButtonItem = nil;
    }
    
    func saveData(){
        dismissKB();
        //save
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        navigationItem.rightBarButtonItem = okItem;
        navigationItem.leftBarButtonItem = cancelItem;
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
        
        let subjectInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        subjectInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        subjectInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
        subjectInfoCell.label.delegate = self;
        
        subjectInfoCell.label.inputView = nil;
        
        if(indexPath.section == 0){ // secao 0
            
            switch (indexPath.row){
            case 0: subjectInfoCell.label.text =  "Code: " + subject.id;
                case 1: subjectInfoCell.label.text = "Name: " + subject.nome;
                case 2:
                    let pick = UIPickerView();
                    pick.delegate = self; pick.dataSource = self;
                    professorText = subjectInfoCell.label;
                    subjectInfoCell.label.inputView = pick;
                    if (subject.professor != nil){
                        subjectInfoCell.label.text = "Professor: " + subject.professor.nome;
                    }
                
                default : subjectInfoCell.label.text = "Professor not registered";
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
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return professors.count;
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return professors[row].nome;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedText = professors[row].nome;
        if let t = professorText{
            t.text = "Professor: " + selectedText;
        }
        if(selectedText != subject.professor.nome){
            wasEdited = true;
            subject.professor = professors[row];
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardShow(notification: NSNotification){
        
        //let addition = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height;
        //adit = self.subjectInfoView.tableView.frame.origin.y;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            //self.subjectInfoView.tableView.frame = CGRectMake(self.subjectInfoView.tableView.frame.origin.x, self.subjectInfoView.tableView.frame.origin.y-self.adit, self.subjectInfoView.tableView.frame.width, self.subjectInfoView.tableView.frame.height);
            self.subjectInfoView.tableView.frame.origin.y = 0;
            }, completion: nil);
    }
    
    func keyboardHide(notification: NSNotification){
        print("hiding");
        //let addition = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size.height;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.subjectInfoView.tableView.frame.origin.y = self.adit;
            //self.subjectInfoView.tableView.frame = CGRectMake(fr.origin.x, fr.origin.y+self.adit, fr.width, fr.height);
            }, completion: nil);
        
    }
}