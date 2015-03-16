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
    
//    func optionsButton(optionButton: UIButton!, didSelectItem index: Int32) {
//            if (index == 1) {
//                performSegueWithIdentifier("MY NEXT VIEW", sender: self);
//            }
//    }
    
    override func viewDidAppear(animated: Bool) {
       // let feedScreen:FeedScreen=FeedScreen();
       // self.presentViewController(feedScreen, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

