//
//  TaskController.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class TaskController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var objects : [String];
    
    required init(coder aDecoder: NSCoder) {
        objects = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10","1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName:UIColorFromRGB(0xFFFFFF)];
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        
        self.title = "Tasks";
        
        var tableView : UITableView = UITableView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height - 100));

        tableView.setContentOffset(CGPointMake(0, CGFloat.max), animated: true);
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.whiteColor();
        tableView.delegate = self;
        tableView.dataSource = self;

        var thirdIndex = NSIndexPath(forRow: 0, inSection: 0);
        tableView.scrollToRowAtIndexPath(thirdIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false);
        
        tableView.backgroundColor = UIColorFromRGB(0x1e3044);
        view.backgroundColor = UIColorFromRGB(0x1e3044);
        view.addSubview(tableView);
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return objects.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/4;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell : UITableViewCell = UITableViewCell();
        var labelCountDown: UILabel = UILabel(frame: CGRectMake(20, 15, view.frame.width, 20));
        var labelTask : UILabel = UILabel(frame: CGRectMake(20, labelCountDown.frame.origin.y + 25, view.frame.width, 40));
        var labelDate : UILabel = UILabel(frame: CGRectMake(20, labelTask.frame.origin.y + 30, view.frame.width, 40));
        
        let image = UIImage(named: "editButton") as UIImage?
        var btnEdit   = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
        btnEdit.frame = CGRectMake(view.frame.width - 40, labelTask.frame.origin.y + 5, 20, 20);
        btnEdit.setImage(image, forState: UIControlState.Normal);
        btnEdit.tag = 3;
        btnEdit.addTarget(self, action: "btnTouched:", forControlEvents: UIControlEvents.TouchUpInside);
        
        labelCountDown.text = "1 Day";//objects[indexPath.row];
        labelCountDown.textColor = UIColor.whiteColor();
        labelCountDown.font = UIFont(name: "Avenir Next", size: 20)
        labelCountDown.textAlignment = NSTextAlignment.Left;
        
        labelTask.text = "Calculus List";//objects[indexPath.row];
        labelTask.textColor = UIColor.whiteColor();
        labelTask.font = UIFont(name: "AvenirNext-Bold", size: 30)
        labelTask.textAlignment = NSTextAlignment.Left;

        labelDate.text = "Date : Tomorrow at 5 PM";//objects[indexPath.row];
        labelDate.textColor = UIColor.whiteColor();
        labelDate.font = UIFont(name: "Avenir Next", size: 15)
        labelDate.textAlignment = NSTextAlignment.Left;
        
        cell.backgroundColor = UIColorFromRGB(0x1e3044);
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false;
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.addSubview(labelCountDown);
        cell.addSubview(labelTask);
        cell.addSubview(labelDate);
        cell.addSubview(btnEdit);
        
        return cell;
    }
    
    func btnTouched(sender:UIButton){
        if(sender.tag == 3){
            println("foi");
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
