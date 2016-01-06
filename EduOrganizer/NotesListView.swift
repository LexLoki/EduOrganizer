//
//  NotesListView.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/28/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation


class NotesListView : UIView{
    
    var tableView : UITableView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;

        //inicializacao da tableView
        tableView = UITableView(frame: CGRectMake(0,0, frame.width, frame.height - 110))
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.UIColorFromRGB(0x1a242e);
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        view.addSubview(tableView);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}