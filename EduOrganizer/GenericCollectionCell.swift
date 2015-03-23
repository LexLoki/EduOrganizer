//
//  SubjectsCell.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class GenericCollectionCell : UICollectionViewCell{
    
    var label: UILabel!;
    var imageView: UIImageView!;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    func setUpCell(view: UIView) {
        
        var size : CGSize = CGSizeMake(0.4 * view.frame.size.width, 0.4 * view.frame.size.width);
        
        imageView = UIImageView(frame: CGRectMake(0,0, size.width,size.height));
        imageView.image = UIImage(named: "BolaMateria");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
        imageView.layer.cornerRadius = imageView.frame.size.height/2;
        imageView.layer.masksToBounds = true;
        imageView.layer.borderWidth = 0;
        
        label = UILabel(frame: CGRectMake(0, 0, size.width, size.height));
        label.numberOfLines = 2;
        label.textColor = UIColor(red: 255.0/255, green: 197.0/255, blue: 97.0/255, alpha: 1);
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textAlignment=NSTextAlignment.Center;
        
        imageView.addSubview(label);
        addSubview(imageView);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}