//
//  ViewController.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/11/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

class FirstVC: UITabBarController, FancyTabBarDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    var firstView : FirstView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = FirstView(view: view, parent: self);
        firstView.fancyTabBar.delegate = self;
        
    }
    
    func didExpand() {
        if(firstView.backGround == nil){
            firstView.backGround = UIImageView(frame: view.bounds);
            firstView.backGround.alpha = 0;
            view.addSubview(firstView.backGround);
        }
        
        UIView.animateWithDuration(0.3, animations: {
            self.firstView.backGround.alpha = 1;
            }, completion: {
                (value: Bool) in
            }
        );
        
        view.bringSubviewToFront(firstView.fancyTabBar);

        var backgroundImage : UIImage = view.convertViewToImage();
        var tintColor : UIColor = UIColor.blackColor().colorWithAlphaComponent(0.5);

        
        var image :  UIImage = backgroundImage.applyBlurWithRadius(10, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil);
        firstView.backGround.image = image;
        
    }
    
    func didCollapse() {   
        UIView.animateWithDuration(0.3, animations: {
            self.firstView.backGround.alpha = 0;
            }, completion: {
                (value: Bool) in
                
                if(value) {
                    self.firstView.backGround.removeFromSuperview();
                    self.firstView.backGround = nil;
                }
                
            }
        );
    }

    func optionsButton(optionButton: UIButton!, didSelectItem index: Int32) {
        println(index);
        if(index==1){  //Adicionar anota
            NSNotificationCenter.defaultCenter().postNotificationName("notesNotification", object: nil)
        }
        else if(index==2){ //Adicionar professor
            
        }
        else if(index==3){ //Adicionar materia
            
        }
        else{ //Adicionar tarefa
            
        }
    }

}

