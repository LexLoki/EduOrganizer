//
//  ImagePickVC.swift
//  Stud
//
//  Created by Pietro Ribeiro Pepe on 4/4/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class ImagePickVC: UIImagePickerController, UIImagePickerControllerDelegate{
    
    
    //Quando usuario seleciona uma imagem no rolo de camera
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let img:UIImage = info[UIImagePickerControllerOriginalImage] as UIImage;
    }
    
}