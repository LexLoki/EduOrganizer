//
//  SchoolScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/13/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SchoolController : UIViewController, TableViewDelegate{

    var professores : NSMutableArray = NSMutableArray();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        
        loadProfessores();
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 25)!, NSForegroundColorAttributeName:UIColorFromRGB(0xFFC561)];
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        
        self.title = "Student";
    
        var horizontalTeachersView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 80, view.frame.width, 120), delegate : self);
        view.addSubview(horizontalTeachersView);
        
        var thirdIndex = NSIndexPath(forRow: 2, inSection: 0);
        horizontalTeachersView.tableView.scrollToRowAtIndexPath(thirdIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false);

        
    }
    
    func tableView(horizontalTableView: HorizontalTableView, didSelectRowAtIndexPath: NSIndexPath) {
        horizontalTableView.tableView.deselectRowAtIndexPath(didSelectRowAtIndexPath, animated: true);
        performSegueWithIdentifier("subjects", sender: nil);
        
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return professores.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 150, 150));
        var imageView : UIImageView = UIImageView(frame: CGRectMake(cell.frame.height/2, 0, 100, 100));
        
        //label.text = objects[cellForRowAtIndexPath.row];
        //label.textAlignment = NSTextAlignment.Center;
        //label.layer.backgroundColor = UIColorFromRGB(0x1e3044).CGColor;
        //label.layer.cornerRadius = 50;
        
        imageView.image = (professores[cellForRowAtIndexPath.row]["imagem"] as UIImage);
        
        imageView.layer.cornerRadius = imageView.frame.size.height/2;
        imageView.layer.masksToBounds = true;
        imageView.layer.borderWidth = 0;
        
        cell.addSubview(imageView);
        //cell.addSubview(label);
        
        return cell;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return 130;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForHeaderInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForFooterInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func loadProfessores(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        var plistPath : String = documentPath.stringByAppendingPathComponent("userData.plist");
        let contents : NSDictionary = NSDictionary(contentsOfFile: plistPath)!;
        var allProf : NSMutableDictionary = contents["professores"] as NSMutableDictionary;
        println(plistPath);
        
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgProf");
        
        for (id, var prof) in allProf{
            
            var mutProf : NSMutableDictionary = prof.mutableCopy() as NSMutableDictionary;
            mutProf.setObject(id, forKey: "id");
            
            var profImg : String = imgPath.stringByAppendingPathComponent(prof["imagem"] as String);
            mutProf.setObject(UIImage(contentsOfFile:profImg)!, forKey: "imagem");
            println(profImg);

            self.professores.addObject(mutProf);
            
        }
    }

}