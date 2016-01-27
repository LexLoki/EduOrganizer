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
    var subjectsView : CollectionGeneric!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjectsView = CollectionGeneric(view: view, parent: self);
        title = "Subjects";
        subjectsView.collectionView.delegate = self;
        subjectsView.collectionView.dataSource = self;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let subjectsDAO = SubjectDAO();
        materias = subjectsDAO.getDataArray() as! Array<SubjectModel>;
        subjectsView.collectionView.reloadData();
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

        
        let subjectsCell : CollectionCellGeneric = collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier",
                                                                  forIndexPath: indexPath) as! CollectionCellGeneric;
        subjectsCell.setUpCell(view);
        subjectsCell.label.text = String(format: "%@\n(%@)",
                                        (materias[indexPath.row].nome),
                                        (materias[indexPath.row].id));
        
        return subjectsCell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        performSegueWithIdentifier("infoSubject", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? SubjectInfoVC;
        destinationVC?.subject = materias[selectedIndex];
    }
    
    func btnTouched(sender:UIButton){
        print(sender.tag);
    }
    
    
    
}