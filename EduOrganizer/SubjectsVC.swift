//
//  SubjectsScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SubjectsVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView: UICollectionView?
    var materias:NSMutableArray = NSMutableArray();
    var size:CGSize = CGSize();
    var selectedIndex:Int = Int();
    
    override func viewDidLoad() {
        //var back:UIImageView=UIImageView(frame: self.view.frame);
        size = CGSizeMake(0.4*self.view.frame.size.width, 0.4*self.view.frame.size.width);
        super.viewDidLoad()
        var tela:CGRect = CGRectMake(self.view.frame.size.width*0.06, self.view.frame.size.height*0.05, self.view.frame.size.width*0.9, self.view.frame.size.height*0.9);
        loadMaterias();
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: tela.origin.y, left: tela.origin.x, bottom: 10, right: tela.origin.x)
        //layout.itemSize = CGSize(width: 40, height: 120)
        layout.itemSize = size;
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.backgroundColor = UIColor(red: 30.0/255, green: 48.0/255, blue: 68.0/255, alpha: 1.0);
        self.view.addSubview(collectionView!)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return materias.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        //cell.backgroundColor = UIColor.orangeColor()
    
        cell = prepareCell(cell,indexPath:indexPath);
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("info", sender: nil)
        selectedIndex = indexPath.row;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? SubjectInfoVC;
        destinationVC?.subject = materias[selectedIndex] as NSMutableDictionary;
    }
    
    func loadMaterias(){
        var documentPath:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        var plistPath:String = documentPath.stringByAppendingPathComponent("userData.plist");
        let contents:NSDictionary = NSDictionary(contentsOfFile: plistPath)!;
        var allMaterias:NSMutableDictionary = contents["materias"] as NSMutableDictionary;
        //println(plistPath);
        //var imgPath:String = documentPath.stringByAppendingPathComponent("imgProf");
        for (id,var mat) in allMaterias{
            //prof = (prof as NSMutableDictionary)
            var mutMat:NSMutableDictionary = mat.mutableCopy() as NSMutableDictionary;
            mutMat.setObject(id, forKey: "sigla");
            self.materias.addObject(mutMat);
        }
    }
    func prepareCell(cell:UICollectionViewCell,indexPath:NSIndexPath)->UICollectionViewCell{
        //var imageView:UIImageView = UIImageView(frame: CGRectMake(0,0,size.width,size.height));
        var imageView:UIImageView = UIImageView(frame: CGRectMake(0,0,size.width,size.height));
        imageView.image = UIImage(named: "BolaMateria");
        imageView.contentMode = UIViewContentMode.ScaleToFill;
        imageView.clipsToBounds = true;
        cell.contentView.addSubview(imageView);
        
        var label:UILabel = UILabel(frame: CGRectMake(0, 0, size.width, size.height));
        label.numberOfLines=2;
        var texto:String = String(format: "%@\n(%@)", (materias[indexPath.row]["nome"] as String), (materias[indexPath.row]["sigla"] as String));
        //var texto:String = (materias[indexPath.row]["nome"] as String) + (materias[indexPath.row]["sigla"] as String);
        label.text=texto;
        //label.text=(materias[indexPath.row]["nome"] as String);
        //label.textColor = UIColor.orangeColor();
        label.textColor = UIColor(red: 255.0/255, green: 197.0/255, blue: 97.0/255, alpha: 1);
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textAlignment=NSTextAlignment.Center;
        imageView.addSubview(label);
        
        var btnEdit   = UIButton.buttonWithType(UIButtonType.System) as UIButton;
        btnEdit.frame = CGRectMake(0, 0, size.width, size.height);
        btnEdit.tag = indexPath.row;
        btnEdit.addTarget(self, action: "btnTouched:", forControlEvents: UIControlEvents.TouchUpInside);
        //cell.contentView.addSubview(btnEdit);
        return cell;
    }
    
    func btnTouched(sender:UIButton){
        println(sender.tag);
    }
    
}