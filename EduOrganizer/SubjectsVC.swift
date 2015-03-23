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
    var materias: Array<SubjectModel> = Array<SubjectModel>();
    var size:CGSize = CGSize();
    var selectedIndex:Int = Int();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        var subjectsView : CollectionGeneric = CollectionGeneric(frame: view.frame, parent: self);
        title = "Subjects";
        subjectsView.collectionView.delegate = self;
        subjectsView.collectionView.dataSource = self;
        
        view = subjectsView;
        
        var subjectsDAO = SubjectDAO();
        materias = subjectsDAO.getDataArray() as Array<SubjectModel>;
        
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
        subjectsCell.label.text = String(format: "%@\n(%@)",
                                        (materias[indexPath.row].nome),
                                        (materias[indexPath.row].id));
        
        return subjectsCell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        performSegueWithIdentifier("info", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? SubjectInfoVC;
//        destinationVC?.subject = materias[selectedIndex] as NSMutableDictionary;
    }
    
    func btnTouched(sender:UIButton){
        println(sender.tag);
    }
    
    
    
}