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
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 25)!, NSForegroundColorAttributeName:UIColorFromRGB(0xFFC561)];
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        
        self.title = "Student";
    
        var horizontalTeachersView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 80, view.frame.width, 120), delegate : self);
        view.addSubview(horizontalTeachersView);
        
        var thirdIndex = NSIndexPath(forRow: 2, inSection: 0);
        horizontalTeachersView.tableView.scrollToRowAtIndexPath(thirdIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false);

        
    }
    
    func tableView(horizontalTableView: HorizontalTableView, didSelectRowAtIndexPath: NSIndexPath) {
        horizontalTableView.tableView.deselectRowAtIndexPath(didSelectRowAtIndexPath, animated: true);
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
        label.layer.backgroundColor = UIColorFromRGB(0x1e3044).CGColor;
        label.layer.cornerRadius = 50;
        
        
        cell.addSubview(label);
        
        return cell;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return 130;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForHeaderInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForFooterInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
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