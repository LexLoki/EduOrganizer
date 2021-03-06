//
//  TaskController.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class TaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tarefas : Array<TaskModel> = Array<TaskModel>();
    var pos = Int()
    
    var taskView:TaskView!;
    
    required init(coder aDecoder: NSCoder) {
        
        let taskDAO = TaskDAO();
        tarefas = taskDAO.getDataArray() as! Array<TaskModel>;
        
        super.init(coder: aDecoder)!;
    }
    
    func notesOn(notification: NSNotification){

        print("observer funfou");
        var selectedIndex = tabBarController!.selectedIndex;
        
        if (selectedIndex == 0){
            performSegueWithIdentifier("addNote", sender: nil);
        }
    }
    
    func refresh(notification: NSNotification){
        let taskDAO = TaskDAO();
        tarefas = taskDAO.getDataArray() as! Array<TaskModel>;
        taskView.tableView.reloadData();
    }
    
//    func professorOn(notification: NSNotification){
//        var addProf = AddProfessor();
//        addProf.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
//        presentViewController(addProf, animated: true, completion: nil);
//    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        
        return true
    }
    
    //editar a tela de tarefas
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            let taskDAO = TaskDAO();
            taskDAO.deleteDataById(tarefas[indexPath.row].id)
            self.tarefas.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated);
        taskView.tableView.setEditing(editing, animated: animated);
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        print("HOHO");
        if(tableView.editing == true){
            return UITableViewCellEditingStyle.Delete
        }
        return UITableViewCellEditingStyle.None;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notesOn:", name:"notesNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh:", name:"addedTask", object: nil)
        
        
//        studentView.sectionSubjects.addTarget(self,
//            action: "sectionTouched:",
//            forControlEvents: UIControlEvents.TouchUpInside);
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "professorOn:", name: "professorNotification", object: nil);
        
        
        taskView = TaskView(view: view, parent: self);
        taskView.tableView.delegate = self;
        taskView.tableView.dataSource = self;
        
        //botao de edit em tarefas
        
        self.navigationItem.leftBarButtonItem = editButtonItem()
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var infoTask = InfoTaskVC()
        infoTask.modalPresentationStyle = UIModalPresentationStyle.OverFullScreen
        presentViewController(infoTask, animated: true, completion: nil)
        
        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        pos = indexPath.row
        
        let taskDate = tarefas[pos].data
        
        let strTaskDate = dateFormatter.stringFromDate(taskDate);
        
        infoTask.infoView.name.text = tarefas[pos].nome
        infoTask.infoView.date.text = strTaskDate
        infoTask.infoView.desc.text = tarefas[pos].descricao
        
        infoTask.infoView.dismissButton.addTarget(self, action: "dismissInfo:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height*0.25;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let taskCell : TaskCell = TaskCell(view: view);
        
        let taskDate = tarefas[indexPath.row].data;
        let currentDate = NSDate();

        let dateFormatter = NSDateFormatter();
        dateFormatter.dateFormat = "dd/MM/yyyy  hh:mm a";
        let strTaskDate = dateFormatter.stringFromDate(taskDate);
        
        let calendar: NSCalendar = NSCalendar.currentCalendar();
        
        //Check for 2.0
        //let flags = NSCalendarUnit.DayCalendarUnit
        let flags = NSCalendarUnit.Day
        //let components = calendar.components(flags, fromDate: currentDate, toDate: taskDate, options: nil);
        let components = calendar.components(flags, fromDate: currentDate, toDate: taskDate, options: NSCalendarOptions.MatchStrictly);
        
        var countDown : String?;
        
        if (components.day > 1){
            countDown = String(components.day) + " days";
        }else if (components.day == 1){
            countDown = String(components.day) + " day";
        }else if (components.day == 0){
            countDown = "Today";
        }else{
            countDown = "Done";
        }
        
        taskCell.labelCountDown.text = countDown;
        taskCell.labelTask.text = tarefas[indexPath.row].nome;
        taskCell.labelDate.text = "Date: " + strTaskDate;
        
        return taskCell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "addNote"){
            
        }
    }
  
    func dismissInfo (sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
