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
}