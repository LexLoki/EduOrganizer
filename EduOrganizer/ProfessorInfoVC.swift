//
//  ProfessorInfo.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/19/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class ProfessorInfo: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var professor:NSMutableDictionary = NSMutableDictionary();
    var size:CGSize = CGSize();
    var dict:NSMutableDictionary = NSMutableDictionary();
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        dict = NSMutableDictionary(objects:["nome","e-mail","telefone"], forKeys:["1","2","3"]);
        size = CGSizeMake(0.4*self.view.frame.size.width, 0.4*self.view.frame.size.width);
        setup();
        let larg:CGFloat = 0.1*self.view.frame.size.height+size.height;
        var tableView : UITableView = UITableView(frame: CGRectMake(0, larg, view.frame.width, view.frame.height-larg));
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.whiteColor();
        tableView.backgroundColor = UIColorFromRGB(0x1a242e);
        view.backgroundColor = UIColor(red: 30/255.0, green: 48/255.0, blue: 68/255.0, alpha: 1.0);
        
        
        view.addSubview(tableView);
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return professor.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section==0){
            return 4;
        }
        return 1+(professor["materias"] as NSArray).count;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height/8.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var offSet:CGFloat = 0.1*view.frame.size.width;
        var caixa : CGRect = CGRectMake(offSet,0,view.frame.size.width-offSet,view.frame.size.height/8.0);
        var cell : UITableViewCell = UITableViewCell();
        var label: UILabel = prepareLabel(indexPath, frame:caixa);
        
        if(indexPath.row==0){
            cell.backgroundColor = UIColor(red: 26/255.0, green: 36/255.0, blue: 46/255.0, alpha: 1.0);
        }
        else{
            cell.backgroundColor = UIColor(red: 30/255.0, green: 48/255.0, blue: 68/255.0, alpha: 1.0);
        }
        
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false;
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        cell.addSubview(label);
        
        return cell;
    }
    
    func prepareLabel(indexPath:NSIndexPath, frame:CGRect)->UILabel{
        println("\(indexPath.row) and \(indexPath.section)")
        var label:UILabel = UILabel(frame: frame);
        label.textColor = UIColor.whiteColor();
        label.textAlignment = NSTextAlignment.Left;
        
        if(indexPath.row == 0){
            label.font = UIFont(name: "AvenirNext-Bold", size: 20);
            if(indexPath.section == 0){
                label.text = "Bio";
            }
            else{
                label.text = "Teachs";
            }
        }
        else{
            label.font = UIFont(name: "Avenir Next", size: 15);
            
            if(indexPath.section == 0){  // secao 0 row>0
                let index:String = String(format: "%d", indexPath.row);
                let area:String = dict[index] as String;
                var texto:String;
                texto = professor[area] as String;
                if(texto.isEmpty){
                    label.text = String(format: "%@ nao informado");
                }
                else{
                    label.text = texto;
                }
            }
            else{  //secao 1 row>0
                label.text = ((professor["materias"] as NSArray)[indexPath.row-1] as String);
            }
        }
        println("did it");
        return label;
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func setup(){
        var imageView:UIImageView = UIImageView(frame: CGRectMake(view.frame.size.width*0.5-size.width*0.5,20,size.width,size.height));
        imageView.image = UIImage(named: "BolaMateria");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
      
        if(!(professor["imagem"] as String).isEmpty){
            imageView.image = (professor["imagemUI"] as UIImage);
            imageView.layer.cornerRadius = imageView.frame.size.height/2;
            imageView.layer.masksToBounds = true;
            imageView.layer.borderWidth = 0;
        }else{
            imageView.image = UIImage(named: "BolaMateria");
        }

        view.addSubview(imageView);
    }
    
}