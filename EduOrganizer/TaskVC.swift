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

    
    var objects : [String];
    
    required init(coder aDecoder: NSCoder) {
        objects = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10","1", "2", "3", "4"];
        super.init(coder: aDecoder);
    }
    
    func notesOn(notification: NSNotification){

        println("observer funfou");
        var selectedIndex = tabBarController!.selectedIndex;
        
        if (selectedIndex == 0){
            performSegueWithIdentifier("addNote", sender: nil);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notesOn:", name:"notesNotification", object: nil)
        
        
        var taskView : TaskView = TaskView(view: view, parent: self);
        taskView.tableView.delegate = self;
        taskView.tableView.dataSource = self;
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var taskCell : TaskCell = TaskCell(view: view);
        taskCell.btnEdit.tag = 3;
        taskCell.btnEdit.addTarget(self,
                                   action: "btnTouched:",
                                   forControlEvents: UIControlEvents.TouchUpInside);
        taskCell.labelCountDown.text = "1 Day";
        taskCell.labelTask.text = "Calculus List";
        taskCell.labelDate.text = "Date : Tomorrow at 5 PM";
        
        return taskCell;
    }
    
    func btnTouched(sender:UIButton){
        if(sender.tag == 3){
            println("foi");
        }
    }
}
