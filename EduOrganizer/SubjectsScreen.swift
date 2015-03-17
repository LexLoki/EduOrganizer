//
//  SubjectsScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/17/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class SubjectsScreen : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tela:CGRect = CGRectMake(self.view.frame.size.width*0.1, self.view.frame.size.height*0.1, self.view.frame.size.width*0.8, self.view.frame.size.height*0.8);
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        collectionView = UICollectionView(frame: tela, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    
}