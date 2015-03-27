//
//  InfoGenericView.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class InfoGenericView : UIView{
    
    var tableView : UITableView!;
    var imageView : UIImageView!;
    var label : UILabel!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        parent.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        var size : CGSize = CGSizeMake(0.4 * frame.size.width,
                                       0.4 * frame.size.width);
        
        imageView = UIImageView(frame: CGRectMake(frame.size.width*0.5 - size.width*0.5,
                                                  20,
                                                  size.width,
                                                  size.height));
        
        imageView.image = UIImage(named: "BolaMateria");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
        imageView.layer.cornerRadius = imageView.frame.size.height/2;
        imageView.layer.masksToBounds = true;
        imageView.layer.borderWidth = 0;
        
        label = UILabel(frame: CGRectMake(0, 0, size.width, size.height));
        label.numberOfLines = 2;
        label.textColor = UIColor.UIColorFromRGB(0xffc561);
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textAlignment = NSTextAlignment.Center;
        imageView.addSubview(label);
        
        let larg : CGFloat = 0.1 * frame.size.height + size.height;
        tableView = UITableView(frame: CGRectMake(0,
                                                  larg,
                                                  frame.width,
                                                  frame.height-(larg+110)));

        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.UIColorFromRGB(0x1a242e);
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        view.addSubview(imageView);
        view.addSubview(tableView);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}