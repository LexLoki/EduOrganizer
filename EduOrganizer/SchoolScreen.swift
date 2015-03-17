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

    var objects : [String];
    
    required init(coder aDecoder: NSCoder) {
        objects = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
    
        var tableView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 0, 300, 300), delegate : self);
        view.addSubview(tableView);
        var botone:UIButton = UIButton(frame: CGRectMake(0, 0, 30, 30));
        botone.addTarget(botone, action:huehue, forControl);
        //[self.playButton addTarget:self action:@selector(enterGame)
        self.view.addSubview(botone);
        
    }
    
    func huehue{
        let goTo:SubjectsScreen=SubjectsScreen();
        self.presentViewController(goTo, animated: true, completion: nil);
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return objects.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell();
        var label : UILabel = UILabel();
        label.text = objects[cellForRowAtIndexPath.row];
        cell.addSubview(label);
        return cell;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return view.frame.size.width;
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