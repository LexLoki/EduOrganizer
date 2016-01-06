//
//  FirstView.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/27/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation


class FirstView : UIView {
    
    var fancyTabBar : FancyTabBar!;
    var backGround : UIImageView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
        
        var buttons: [String] = ["actionNote", "actionTeacher", "actionClass", "actionTask"];
        var image : UIImage = UIImage(named: "mainButton")!;
        
        let attributesNormal = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 10)!,
            NSForegroundColorAttributeName:UIColor.whiteColor()];
        let attributesSelected = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 10)!,
            NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFC561)];
        
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, forState: UIControlState.Normal);
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, forState: UIControlState.Selected);
        
        var taskItem : UITabBarItem = (parent as! FirstVC).tabBar.items![0] as! UITabBarItem;
        var studentItem : UITabBarItem = (parent as! FirstVC).tabBar.items![2] as! UITabBarItem;
        
        var taskImage : UIImage = UIImage(named: "itemTask")!;
        taskItem.image = taskImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var studentImage : UIImage = UIImage(named: "itemStudent")!;
        studentItem.image = studentImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        fancyTabBar = FancyTabBar(frame: frame);
        fancyTabBar.setUpChoices(parent, choices: buttons, withMainButtonImage: image);
        
        view.addSubview(fancyTabBar);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}