//
//  ProtocolPListDAO.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation


@objc protocol ProtocolDAO{
    
    func getDataArray() -> Array<AnyObject>;
    func getDataById(id : AnyObject) -> AnyObject;
    optional func saveData(object : AnyObject);
    optional func deleteDataById(id : AnyObject);
    
}

class StudDAO {
    
    var contents : NSMutableDictionary!;
    var plistPath : String!;
    
    init(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                                                        .UserDomainMask, true)[0] as String;
    
        plistPath = documentPath.stringByAppendingPathComponent("userData.plist");
        contents = NSMutableDictionary(contentsOfFile: plistPath)!;
        
    }
    
    func getFreeIdInDict(dict:NSDictionary) -> String{
        
        var id : Int = 0;
        var idArray : NSArray = dict.allKeys;
        for(id = 0 ; idArray.containsObject(String(id)); id++){
        };
        
        return String(id);
    }
    
    func loadPList() -> NSMutableDictionary?{
        return nil;
    }
    
    func checkFiles(filename:String, type:String){
        
        var destPath:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
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