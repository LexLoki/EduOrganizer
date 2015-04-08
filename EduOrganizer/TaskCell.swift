//
//  TaskCell.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class TaskCell : UITableViewCell{
    
    var labelCountDown : UILabel!;
    var labelTask : UILabel!;
    var labelDate : UILabel!;
    var rightArrow: UIImageView!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    init(view: UIView) {
        super.init(frame: view.frame);
        
        labelCountDown = UILabel(frame: CGRectMake(20, 15, view.frame.width, 20));
        labelTask = UILabel(frame: CGRectMake(20, labelCountDown.frame.origin.y + 25, view.frame.width*0.75, 40));
        labelDate = UILabel(frame: CGRectMake(20, labelTask.frame.origin.y + 30, view.frame.width, 40));
        
        labelCountDown.textColor = UIColor.whiteColor();
        labelCountDown.font = UIFont(name: "Avenir Next", size: 20)
        labelCountDown.textAlignment = NSTextAlignment.Left;
 
        labelTask.textColor = UIColor.whiteColor();
        labelTask.font = UIFont(name: "AvenirNext-DemiBold", size: 30)
        labelTask.textAlignment = NSTextAlignment.Left;
        
        labelDate.textColor = UIColor.whiteColor();
        labelDate.font = UIFont(name: "Avenir Next", size: 15)
        labelDate.textAlignment = NSTextAlignment.Left;
        
        let image = UIImage(named: "rightArrow") as UIImage?
        rightArrow = UIImageView (frame: (CGRectMake(view.frame.width - 40, labelTask.frame.origin.y + 5, 20, 20)))

     
        rightArrow.image = image
        
        backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        layoutMargins = UIEdgeInsetsZero;
        preservesSuperviewLayoutMargins = false;
        selectionStyle = UITableViewCellSelectionStyle.None;
        
        self.contentView.addSubview(rightArrow)
        self.contentView.addSubview(labelCountDown);
        self.contentView.addSubview(labelTask);
        self.contentView.addSubview(labelDate);

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}