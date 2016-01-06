//
//  CoverDAO.swift
//  Stud
//
//  Created by Pietro Ribeiro Pepe on 7/21/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

class CoverDAO{
    
    private var contents : NSMutableDictionary!;
    private let coverPath : String;
    private let coverFolderPath : String;
    
    init(){
        let documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as! String;
        coverFolderPath = documentPath.stringByAppendingPathComponent("Cover");
        coverPath = documentPath.stringByAppendingPathComponent("Cover/coverData.plist");
        
        let fileManager = NSFileManager.defaultManager();
        if (fileManager.fileExistsAtPath(coverFolderPath)){
            contents = NSMutableDictionary(contentsOfFile: coverPath);
        }
        else{
            do{
                try fileManager.createDirectoryAtPath(coverFolderPath, withIntermediateDirectories: false, attributes: nil);
            }
            catch{
                print("Error creating cover directory");
            }
            createDict();
        }
    }
    
    private func createDict(){
        contents = NSMutableDictionary(objects: ["",""], forKeys: ["name","title"]);
        contents.writeToFile(coverPath, atomically: true);
    }
    
    func getData() -> CoverModel?{
        var cover = CoverModel();
        cover.name = contents["name"] as! String;
        if(cover.name.isEmpty){
            return nil;
        }
        cover.title = contents["title"] as! String;
        cover.imageProfile = coverFolderPath + "/user.png";
        
        let path = coverFolderPath + "/back.png";
        if(NSFileManager.defaultManager().fileExistsAtPath(path)){
            cover.imageBackground = path;
        }
        else{
            //cover.imageBackground = "";
        }
        
        return cover;
    }
    
    func saveData(cover : CoverModel, userImg : UIImage, backgroundImg : UIImage?){
        contents["name"] = cover.name;
        contents["title"] = cover.title;
        saveImgToPath(userImg, name: "user.png");
        if(backgroundImg != nil){
            saveImgToPath(backgroundImg!, name: "back.png");
        }
        else{
            
        }
        contents.writeToFile(coverPath, atomically: true);
    }
    
    private func deleteImg(name : String){
        let fileManager = NSFileManager.defaultManager();
        let path = coverFolderPath.stringByAppendingPathComponent(name);
        do{
            try fileManager.removeItemAtPath(path);
        }
        catch{
            print("Error removing cover img at \(path)")
        }
    }
    
    private func saveImgToPath(img : UIImage, name : String){
        UIImagePNGRepresentation(img)!.writeToFile(coverFolderPath+"/"+name, atomically: true);
    }
}