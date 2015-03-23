//
//  SubjectsCell.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class SubjectsCell : UICollectionViewCell{
    
    var label: UILabel!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    func setUpCell(view: UIView) {
        
        var size : CGSize = CGSizeMake(0.4 * view.frame.size.width, 0.4 * view.frame.size.width);
        
        var imageView : UIImageView = UIImageView(frame: CGRectMake(0,0, size.width,size.height));
        imageView.image = UIImage(named: "BolaMateria");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
        
        label = UILabel(frame: CGRectMake(0, 0, size.width, size.height));
        label.numberOfLines = 2;
        label.textColor = UIColor(red: 255.0/255, green: 197.0/255, blue: 97.0/255, alpha: 1);
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textAlignment=NSTextAlignment.Center;
        
        imageView.addSubview(label);
        addSubview(imageView);
        
//        btnEdit = UIButton.buttonWithType(UIButtonType.System) as UIButton;
//        btnEdit.frame = CGRectMake(0, 0, size.width, size.height);
//        btnEdit.tag = indexPath.row;
//        btnEdit.addTarget(self, action: "btnTouched:", forControlEvents: UIControlEvents.TouchUpInside);

        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}