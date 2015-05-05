//
//  StudenCell.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class StudentCell : UITableViewCell{
    
    var btnCell : UIButton!;
    var label: UILabel!;
    
    init(view: UIView) {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        //self.frame = view.frame;
        
        var size : CGSize = CGSizeMake(0.35 * frame.size.width,
                                       0.35 * frame.size.width);
        
        
        label = UILabel(frame: CGRectMake(frame.height/2.5, frame.height/2.5, size.width, size.height));
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
        label.numberOfLines = 2;
        label.textColor = UIColor.UIColorFromRGB(0xffc561);
        label.textAlignment = NSTextAlignment.Center;
        
        btnCell = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton;
        btnCell.frame = label.frame;
        btnCell.layer.cornerRadius = btnCell.frame.size.height/2;
        btnCell.layer.masksToBounds = true;
        btnCell.contentMode = UIViewContentMode.ScaleAspectFit;
        btnCell.layer.borderWidth = 0;
        btnCell.setImage(UIImage(named: "BolaMateria"), forState: UIControlState.Normal);
        
        selectionStyle = UITableViewCellSelectionStyle.None;
        backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        self.contentView.addSubview(btnCell);
        self.contentView.addSubview(label);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}