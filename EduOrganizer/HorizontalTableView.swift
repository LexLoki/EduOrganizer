//
//  HorizontalTableView.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/16/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewDelegate{
    
    func tableView(horizontalTableView : HorizontalTableView, numberOfRows : Int) -> Int;
    func tableView(horizontalTableView : HorizontalTableView, cellForRowAtIndexPath : NSIndexPath) -> UITableViewCell;
    
    func numberOfSectionsInTableView(horizontalTableView : HorizontalTableView) -> Int;
    func tableView(horizontalTableView : HorizontalTableView, didSelectRowAtIndexPath : NSIndexPath);
    func tableView(horizontalTableView : HorizontalTableView, viewForHeaderInSection : Int) -> UIView;
    func tableView(horizontalTableView : HorizontalTableView, viewForFooterInSection : Int) -> UIView;
    func tableView(horizontalTableView : HorizontalTableView, widthForCellAtIndexPath : NSIndexPath) -> CGFloat;
    
    
}

class HorizontalTableView: UIView , UITableViewDelegate, UITableViewDataSource {

    
    var delegate : TableViewDelegate?;
    var tableView : UITableView!;
    
    init(frame: CGRect, delegate : TableViewDelegate, color : UIColor) {
        super.init(frame: frame);
        
        self.tableView = UITableView(frame: frame);
        
        refreshOrientation();
        
        self.delegate = delegate;
        self.tableView.separatorColor = color;
        self.tableView.backgroundColor = color;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.autoresizingMask	= UIViewAutoresizing.FlexibleWidth |
                                          UIViewAutoresizing.FlexibleHeight;
        addSubview(tableView);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionView : UIView = self.delegate!.tableView(self, viewForHeaderInSection: section);
        return viewToHoldSectionView(sectionView);
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var sectionView : UIView = self.delegate!.tableView(self, viewForFooterInSection: section);
        return viewToHoldSectionView(sectionView);
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.delegate!.tableView(self, widthForCellAtIndexPath: indexPath);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate!.tableView(self, numberOfRows: section);
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func refreshOrientation(){
        
        if (self.tableView == nil){
            return;
        }

        
        // First reset rotation
        self.tableView.transform = CGAffineTransformIdentity;
        self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        
        // Adjust frame
        var xOrigin  = (self.bounds.size.width - self.bounds.size.height)/2;
        var yOrigin = (self.bounds.size.height - self.bounds.size.width) / 2.0;
        
        self.tableView.frame = CGRectMake(xOrigin, yOrigin, self.bounds.size.height, self.bounds.size.width);
        
        // Apply rotation again
        self.tableView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI)/2);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.bounds.size.height - 7.0);

    }
    
    func viewToHoldSectionView (sectionView : UIView) -> UIView{
        
        sectionView.frame = CGRectMake(0, 0, sectionView.frame.size.width, self.frame.size.height);
        
        var rotatedView : UIView = UIView(frame: sectionView.frame);
        
        rotatedView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)/2.0);
        sectionView.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin;
        rotatedView.addSubview(sectionView);
        
        return rotatedView;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        var cell : UITableViewCell = self.delegate!.tableView(self, cellForRowAtIndexPath: indexPath);
        
        // Rotate if needed
        if (CGAffineTransformEqualToTransform(cell.contentView.transform, CGAffineTransformIdentity)){
            
            var xOrigin = (cell.bounds.size.width - cell.bounds.size.height) / 2.0;
            var yOrigin	= (cell.bounds.size.height - cell.bounds.size.width) / 2.0;
            
            cell.contentView.frame = CGRectMake(xOrigin, yOrigin, cell.bounds.size.height, cell.bounds.size.width);
            cell.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2));
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return self.delegate!.tableView(self, didSelectRowAtIndexPath: indexPath);
    }
    
}
