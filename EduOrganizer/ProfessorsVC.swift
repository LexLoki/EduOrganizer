//
//  ProfessorsController.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/18/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class ProfessorsVC : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var professorsView : CollectionGeneric!;
    var professores: Array<ProfessorModel> = Array<ProfessorModel>();
    var selectedIndex:Int = Int();
    
    func refresh(notification : NSNotification){
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as! Array<ProfessorModel>;
        professorsView.collectionView.reloadData();
    }
    
    override func viewDidLoad() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "refresh:", name:"addedNote", object: nil)
        
        professorsView  = CollectionGeneric(view: view, parent: self);
        title = "Professors";
        professorsView.collectionView.delegate = self;
        professorsView.collectionView.dataSource = self;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as! Array<ProfessorModel>;
        professorsView.collectionView.reloadData();
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return professores.count;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2;
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var professorsCell : CollectionCellGeneric =    collectionView.dequeueReusableCellWithReuseIdentifier("cellIdentifier",
                                                                  forIndexPath: indexPath) as! CollectionCellGeneric;
        professorsCell.setUpCell(view);
        
        if let image = professores[indexPath.row].imagem {
            professorsCell.imageView.image = UIImage(contentsOfFile:professores[indexPath.row].imagem);
        }else{
            professorsCell.label.font = UIFont(name: "AvenirNext-DemiBold", size: 40)
            professorsCell.label.text = String.getAbrevName(professores[indexPath.row].nome);
        }
        
        return professorsCell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        performSegueWithIdentifier("infoProfessor", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? ProfessorInfoVC;
        destinationVC?.professor = professores[selectedIndex];
    }
    
    func btnTouched(sender:UIButton){
        print(sender.tag);
    }

}