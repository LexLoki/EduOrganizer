//
//  InfoCellGeneric.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

class InfoCellGeneric : UITableViewCell{
    
    //var label : UILabel!;
    var label : UITextField!;
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
//        super.init(style: style, reuseIdentifier: reuseIdentifier);
//    }
//    
    init(view: UIView) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)        
        self.frame = view.frame;
        
        layoutMargins = UIEdgeInsetsZero;
        preservesSuperviewLayoutMargins = false;
        selectionStyle = UITableViewCellSelectionStyle.None;
        layoutMargins = UIEdgeInsetsZero;
        
        label = UITextField(frame: CGRectMake(20, 18, view.frame.width, 20));
        label.textColor = UIColor.whiteColor();
        label.textAlignment = NSTextAlignment.Left;
        
        addSubview(label);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}