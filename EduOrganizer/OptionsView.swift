//
//  StudenSectionView.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/27/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class OptionsView : UIView {
    
    var labelOne : UILabel!;
    var labelTwo : UILabel!;
    var labelThree : UILabel!;

    var sectionOne : UIButton = UIButton();
    var sectionTwo : UIButton = UIButton();
    var sectionThree : UIButton = UIButton();
    
    init(frame : CGRect, rows : CGFloat) {
        super.init(frame: frame);
        
        sectionOne = UIButton(frame: CGRectMake(0,
            0,
            frame.width,
            frame.height/rows));
        
        sectionTwo = UIButton();
        sectionThree = UIButton();
        
        sectionOne.tag = 0;
        sectionTwo.tag = 1;
        sectionThree.tag = 2;
        
        labelOne = UILabel(frame: CGRectMake(sectionOne.frame.origin.x + 20,
            sectionOne.frame.origin.y,
            frame.width,
            sectionOne.frame.height));
        
        labelTwo = UILabel();
        labelThree = UILabel();
        
        backgroundColor = UIColor.UIColorFromRGB(0x656779);
        
        sectionOne.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        sectionTwo.backgroundColor = UIColor.UIColorFromRGB(0x2B4C6F);
        
        sectionTwo.frame = sectionOne.frame;
        sectionTwo.frame.origin.y = sectionOne.frame.origin.y + sectionOne.frame.height;


        labelOne = UILabel.setFontStyle(labelOne, sizeFont : 15);
        labelTwo = UILabel.setFontStyle(labelTwo, sizeFont : 15);
        
        labelTwo.frame = labelOne.frame;
        labelTwo.frame.origin.y = labelOne.frame.origin.y + labelOne.frame.height;
        
        if (rows == 3){
            sectionThree.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
            sectionThree.frame = sectionTwo.frame;
            sectionThree.frame.origin.y = sectionTwo.frame.origin.y + sectionTwo.frame.height;
            
            labelThree = UILabel.setFontStyle(labelThree, sizeFont : 15);
            labelThree.frame = labelTwo.frame;
            labelThree.frame.origin.y = labelTwo.frame.origin.y + labelTwo.frame.height;
            
            addSubview(sectionThree);
            addSubview(labelThree);
        }
        
        addSubview(sectionOne);
        addSubview(labelOne);
        addSubview(sectionTwo);
        addSubview(labelTwo);
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
