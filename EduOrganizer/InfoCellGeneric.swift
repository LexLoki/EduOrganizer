//
//  InfoCellGeneric.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class InfoCellGeneric : UITableViewCell{
    
    var label : UILabel!;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    init(view: UIView) {
        super.init(frame: view.frame);
        
        var offSet : CGFloat = 0.1 * view.frame.size.width;
        var caixa : CGRect = CGRectMake(offSet,
                                        0,
                                        view.frame.size.width-offSet,
                                        view.frame.size.height/8.0);
        
        layoutMargins = UIEdgeInsetsZero;
        preservesSuperviewLayoutMargins = false;
        selectionStyle = UITableViewCellSelectionStyle.None;
        layoutMargins = UIEdgeInsetsZero;
        
        label = UILabel(frame: CGRectMake(20, 15, view.frame.width, 20));
        label.textColor = UIColor.whiteColor();
        label.textAlignment = NSTextAlignment.Left;
        
        addSubview(label);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}