//
//  SubjectsView.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class SubjectsView : UIView{
    
    var collectionView: UICollectionView!;
    var size: CGSize = CGSize();
    
    
    init(frame: CGRect, parent: UIViewController) {
        super.init(frame: frame);
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName:UIColor.UIColorFromRGB(0xFFFFFF)];
        parent.navigationController?.navigationBar.titleTextAttributes = attributes;
        parent.title = "Subjects";
        
        size = CGSizeMake(0.4 * frame.size.width, 0.4 * frame.size.width);

        var tela:CGRect = CGRectMake(frame.size.width*0.06,
                                     frame.size.height*0.05,
                                     frame.size.width*0.9,
                                     frame.size.height*0.9);

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: tela.origin.y,
                                           left: tela.origin.x,
                                           bottom: 10,
                                           right: tela.origin.x);

        layout.itemSize = size;
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout);
        collectionView.registerClass(SubjectsCell.self, forCellWithReuseIdentifier: "cellIdentifier");
        collectionView!.backgroundColor = UIColor(red: 30.0/255, green: 48.0/255, blue: 68.0/255, alpha: 1.0);
        addSubview(collectionView!)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}