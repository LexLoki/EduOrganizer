//
//  ViewController.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/11/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

class ViewController: UITabBarController, FancyTabBarDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    var fancyTabBar : FancyTabBar!;
    var backGround : UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons: [String] = ["actionNote", "actionTeacher", "actionClass", "actionTask"];
        var image : UIImage = UIImage(named: "mainButton")!;
        
        //set font tabBar item
        let attributesNormal = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 10)!, NSForegroundColorAttributeName:UIColor.whiteColor()];
        let attributesSelected = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 10)!, NSForegroundColorAttributeName:UIColorFromRGB(0xFFC561)];
        UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, forState: UIControlState.Normal);
        UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, forState: UIControlState.Selected);
        
        //set color tabBar Image
        var taskItem : UITabBarItem = self.tabBar.items![0] as UITabBarItem;
        var studentItem : UITabBarItem = self.tabBar.items![2] as UITabBarItem;
        
        var taskImage : UIImage = UIImage(named: "itemTask")!;
        taskItem.image = taskImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

        var studentImage : UIImage = UIImage(named: "itemStudent")!;
        studentItem.image = studentImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        fancyTabBar = FancyTabBar(frame: view.frame);
        fancyTabBar.setUpChoices(self, choices: buttons, withMainButtonImage: image);
        fancyTabBar.delegate = self;
        
        view.addSubview(fancyTabBar);
        
    }
    func didExpand() {
        if(backGround == nil){
            backGround = UIImageView(frame: view.bounds);
            backGround.alpha = 0;
            view.addSubview(backGround);
        }
        
        UIView.animateWithDuration(0.3, animations: {
            self.backGround.alpha = 1;
            }, completion: {
                (value: Bool) in
            }
        );
        
        view.bringSubviewToFront(fancyTabBar);

        var backgroundImage : UIImage = view.convertViewToImage();
        var tintColor : UIColor = UIColor.blackColor().colorWithAlphaComponent(0.5);

        
        var image :  UIImage = backgroundImage.applyBlurWithRadius(10, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil);
        backGround.image = image;
        
    }
    
    func didCollapse() {   
        UIView.animateWithDuration(0.3, animations: {
            self.backGround.alpha = 0;
            }, completion: {
                (value: Bool) in
                
                if(value) {
                    self.backGround.removeFromSuperview();
                    self.backGround = nil;
                }
                
            }
        );
    }

    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


}

