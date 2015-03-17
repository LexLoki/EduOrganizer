//
//  SchoolScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/13/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SchoolScreen : UIViewController, TableViewDelegate{

    var objects : [String] = [];
    
    override func viewDidLoad() {
        
        objects = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
    
        var tableView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 30, view.frame.width, 100), delegate : self);
        view.addSubview(tableView);
        
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
        
        //label.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        
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