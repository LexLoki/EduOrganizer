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
    

    var professores: Array<ProfessorModel> = Array<ProfessorModel>();
    var selectedIndex:Int = Int();
    
    override func viewDidLoad() {

        var professorsView : CollectionGeneric = CollectionGeneric(frame: view.frame, parent: self);
        title = "Professors";
        professorsView.collectionView.delegate = self;
        professorsView.collectionView.dataSource = self;
        
        view = professorsView;
        
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as Array<ProfessorModel>;
        
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
                                                                  forIndexPath: indexPath) as CollectionCellGeneric;
        professorsCell.setUpCell(view);
        
        if let image = professores[indexPath.row].imagem {
            professorsCell.imageView.image = professores[indexPath.row].imagem;
        }
        
        var nameProfessor : String = String(format: "%@", (professores[indexPath.row].nome as String));
        professorsCell.label.text = nameProfessor;
        
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
        println(sender.tag);
    }

}