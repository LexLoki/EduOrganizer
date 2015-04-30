//
//  StudUtils.swift
//  Stud
//
//  Created by Haroldo Olivieri on 4/1/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class StudUtils{
    
    class func checkFiles(filename:String, type:String){
        
        var destPath:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        var imgPath:String = destPath;
        destPath = destPath.stringByAppendingPathComponent("\(filename)\(type)");
        
        println(destPath);
        
        // If the file doesn't exist in the Documents Folder, copy it.
        var fileManager:NSFileManager = NSFileManager.defaultManager();
        if(!fileManager.fileExistsAtPath(destPath)){
            let sourcePath:String = NSBundle.mainBundle().pathForResource(filename, ofType: type)!;
            fileManager.copyItemAtPath(sourcePath, toPath: destPath, error: nil);
        }
        
        var imgProfPath = imgPath.stringByAppendingPathComponent("imgProf");
        
        fileManager.createDirectoryAtPath(imgProfPath, withIntermediateDirectories:false, attributes:nil, error:nil);
        
        var filename:String = "christine";
        var img:UIImage = UIImage(named: filename)!;
        var pngData:NSData = UIImagePNGRepresentation(img);
        var imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
        
        filename = "hugofuks";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
        
        filename = "spesco";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
        
        /*
        ///
        */
        
        var imgNotePath = imgPath.stringByAppendingPathComponent("imgNote");
        
        fileManager.createDirectoryAtPath(imgNotePath, withIntermediateDirectories:false, attributes:nil, error:nil);
        
        filename = "note";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        var imgNotePath2 = imgNotePath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgNotePath2, contents: pngData, attributes:nil);
        
    }
}