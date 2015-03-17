//
//  SchoolScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/13/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SchoolController : UIViewController, TableViewDelegate{

    var objects : [String];
    
    required init(coder aDecoder: NSCoder) {
        objects = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
    
        var horizontalTeachersView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 80, view.frame.width, 100), delegate : self);
        view.addSubview(horizontalTeachersView);
        
        let uiButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        uiButton.frame = CGRectMake(16, 200, 288, 30)
        uiButton.setTitle("Second", forState: UIControlState.Normal);
        uiButton.addTarget(self, action: "buttonActionFromCode:",
            forControlEvents: UIControlEvents.TouchUpInside);
        
        view.addSubview(horizontalTeachersView);
        view.addSubview(uiButton);
        
    }
    
    func buttonActionFromCode(sender:UIButton){
        performSegueWithIdentifier("subjects", sender: nil);
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return objects.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 150, 150));
        var label : UILabel = UILabel(frame: CGRectMake(cell.frame.height/2, 0, 100, 100));
        
        label.text = objects[cellForRowAtIndexPath.row];
        label.textAlignment = NSTextAlignment.Center;
        label.layer.backgroundColor = UIColor.redColor().CGColor;
        label.layer.cornerRadius = 50;
        
        
        cell.addSubview(label);
        
        return cell;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return 150;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, didSelectRowAtIndexPath: NSIndexPath) {
        horizontalTableView.tableView.deselectRowAtIndexPath(didSelectRowAtIndexPath, animated: true);
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForHeaderInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForFooterInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
}