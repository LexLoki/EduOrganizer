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
        
        StudUtils.checkFiles("userData", type: ".plist");
        super.init(coder: aDecoder)!;
    }
    
    var firstView : FirstView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView = FirstView(view: view, parent: self);
        firstView.fancyTabBar.delegate = self;
        
    }
    
    override func viewDidAppear(animated: Bool) {
       print("HUEHUEHEUHE");
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

        let backgroundImage : UIImage = view.convertViewToImage();
        let tintColor : UIColor = UIColor.blackColor().colorWithAlphaComponent(0.5);

        
        let image :  UIImage = backgroundImage.applyBlurWithRadius(10, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil);
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
        print(index);
        if(index==1){  //Adicionar anotações
            NSNotificationCenter.defaultCenter().postNotificationName("notesNotification", object: nil)
        }else if(index==2){ //Adicionar professor
            
            /*
            let blurEffect = UIBlurEffect(style: .Dark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
            blurView.frame = view.bounds;
            blurView.alpha=0.7;
            view.addSubview(blurView);
            
            let vibrancyEf = UIVibrancyEffect(forBlurEffect: blurEffect);
            let vibView = UIVisualEffectView(effect: vibrancyEf);
            vibView.setTranslatesAutoresizingMaskIntoConstraints(false);
            blurView.contentView.addSubview(vibView);
            */

            //NSNotificationCenter.defaultCenter().postNotificationName("professorNotification", object: nil);
            
            let addProf = AddProfessorVC();
            addProf.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
            presentViewController(addProf, animated: true, completion: nil);
            
        }else if(index == 3){ //Adicionar materia
            let addSubject = AddSubjectVC();
            addSubject.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
            presentViewController(addSubject, animated: true, completion: nil);
        }else{
            
            //Adicionar tarefa
            let addTask = AddTaskVC()
//            //estilo de apresentacao sobre o contexto//
            addTask.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext;
            presentViewController(addTask, animated: true, completion: nil)
        }
    }

    //IR PARA PARTE DE VIEW
    func imageFromView()->UIImage{
        UIGraphicsBeginImageContext(view.bounds.size);
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true);
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

