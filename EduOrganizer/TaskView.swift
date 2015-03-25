//
//  TaskView.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class TaskView : UIView {
    
    var tableView : UITableView!;
    
    init(frame: CGRect, parent: UIViewController) {
        super.init(frame: frame);

        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        parent.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        parent.title = "Tasks";
        
        tableView = UITableView(frame: CGRectMake(0, 0, frame.width, frame.height - 110));
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.whiteColor();
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        
        backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        addSubview(tableView);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}