//
//  ProfessorInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/19/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class ProfessorInfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    var professor: ProfessorModel = ProfessorModel();
    var deleteItem : UIBarButtonItem!;
    var deleteAlert : UIAlertController!;
    var okItem : UIBarButtonItem!;
    var cancelItem : UIBarButtonItem!;
    var professorInfoView : InfoGenericView!;
    
    var adit:CGFloat!;
    
    
    override func viewWillAppear(animated: Bool) {
        professor.materias = SubjectDAO().getSubjectsByIdProfessor(professor.id);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardShow:" , name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardHide:" , name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        professorInfoView = InfoGenericView(view: view, parent: self);
        professorInfoView.tableView.delegate = self;
        professorInfoView.tableView.dataSource = self;
        
        title = professor.nome;
        
        deleteItem = UIBarButtonItem(image: UIImage(named: "trash"), style: .Plain, target: self, action: "deleteProfessorAlert");
        navigationItem.rightBarButtonItem = deleteItem;
        
        deleteAlert = UIAlertController(title: "Confirm deletion",
            message: "Delete professor " + title! + "?",
            preferredStyle: .ActionSheet);
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil);
        let okAction:UIAlertAction = UIAlertAction(title: "Delete", style: .Destructive, handler: deleteProfessor);
        deleteAlert.addAction(cancelAction);
        deleteAlert.addAction(okAction);
    
       
        
        if let image = professor.imagem {
            professorInfoView.imageView.image = UIImage(contentsOfFile:professor.imagem);
        }else{
            professorInfoView.label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
            professorInfoView.label.text = String.getAbrevName(professor.nome);
        }
        
        okItem = UIBarButtonItem(title: "Save",style: .Done,target: self,action: "saveData");
        cancelItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissKB");
        
        adit = professorInfoView.tableView.frame.origin.y;
        
    }
    
    func dismissKB(){
        self.view.endEditing(true);
        navigationItem.rightBarButtonItem = deleteItem;
        navigationItem.leftBarButtonItem = nil;
        //ProfessorDAO().saveData(professor);
    }
    
    func saveData(){
        dismissKB();
        //then save
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        navigationItem.rightBarButtonItem = okItem;
        navigationItem.leftBarButtonItem = cancelItem;
    }
    
    func deleteProfessorAlert(){
        presentViewController(deleteAlert, animated: true, completion: nil);
    }
    
    
    func deleteProfessor(alert: UIAlertAction!){
        ProfessorDAO().deleteDataById(professor.id);
        navigationController?.popViewControllerAnimated(true);
    }

    
    func editMode(){
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(section == 0){
            return 3;
        }
        
        return professor.materias.count;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height/10;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header : InfoCellGeneric = InfoCellGeneric(view: view);
        header.label.userInteractionEnabled = false;
        header.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        header.label.font = UIFont(name: "AvenirNext-Bold", size: 20);
        if(section==0){
            header.label.text = "Bio";
        }
        else{
            header.label.text = "Teachs";
        }
        return header;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/10;
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var professorInfoCell : InfoCellGeneric = InfoCellGeneric(view: view);
        
        professorInfoCell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        professorInfoCell.label.font = UIFont(name: "Avenir Next", size: 15);
        professorInfoCell.label.delegate=self;
        
        if(indexPath.section == 0){  // secao 0 row>0
            
            switch (indexPath.row){
                case 0: professorInfoCell.label.text = "Name: " + professor.nome;
                case 1: professorInfoCell.label.text = "E-mail: " + professor.email;
                case 2: professorInfoCell.label.text = "Phone: " + professor.telefone;
                default : professorInfoCell.label.text = "error";
            }
            
        }else{
            
            var subjectStr = (professor.materias[indexPath.row] as SubjectModel).id + " / " +
                             (professor.materias[indexPath.row] as SubjectModel).nome;
            
            professorInfoCell.label.text = subjectStr;
        }
        
        return professorInfoCell;
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        print("disappearing");
        NSNotificationCenter.defaultCenter().removeObserver(self);
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil);
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil);
    }
    
    func keyboardShow(notification: NSNotification){
        //let addition = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size.height;
        //adit = self.professorInfoView.tableView.frame.origin.y;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            //self.professorInfoView.tableView.frame = CGRectMake(self.professorInfoView.tableView.frame.origin.x, self.professorInfoView.tableView.frame.origin.y-self.adit, self.professorInfoView.tableView.frame.width, self.professorInfoView.tableView.frame.height);
            self.professorInfoView.tableView.frame.origin.y = 0;
            }, completion: nil);
    }
    
    func keyboardHide(notification: NSNotification){
        //let addition = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size.height;
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            //self.professorInfoView.tableView.frame = CGRectMake(self.professorInfoView.tableView.frame.origin.x, self.professorInfoView.tableView.frame.origin.y+self.adit, self.professorInfoView.tableView.frame.width, self.professorInfoView.tableView.frame.height);
            self.professorInfoView.tableView.frame.origin.y = self.adit;
            }, completion: nil);

    }

    
}