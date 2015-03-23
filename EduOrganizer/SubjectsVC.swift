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
        super.viewDidLoad()
    
        var subjectsView : CollectionGeneric = CollectionGeneric(frame: view.frame, parent: self);
        title = "Subjects";
        subjectsView.collectionView.delegate = self;
        subjectsView.collectionView.dataSource = self;
        
        view = subjectsView;
        
        loadMaterias();

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

        
        var subjectsCell : CollectionCellGeneric = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier",
                                                                  forIndexPath: indexPath) as CollectionCellGeneric;
        subjectsCell.setUpCell(view);
        
        var materiaStr : String = String(format: "%@\n(%@)",
                                 (materias[indexPath.row]["nome"] as String),
                                 (materias[indexPath.row]["sigla"] as String));
        
        subjectsCell.label.text = materiaStr;
        
        return subjectsCell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        performSegueWithIdentifier("info", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? SubjectInfoVC;
        destinationVC?.subject = materias[selectedIndex] as NSMutableDictionary;
    }
    
    
    //IR PARA MATERIAS DAO
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

    func btnTouched(sender:UIButton){
        println(sender.tag);
    }
    
    
    
}