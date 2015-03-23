//
//  ProtocolPListDAO.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation


protocol ProtocolDAO{
    
    func loadPList() -> NSMutableDictionary;
    func getDataArray() -> Array<AnyObject>;
    func getDataById(id : AnyObject) -> AnyObject;
    
}

class StudDAO {
    
    var contents : NSDictionary!;
    
    init(){
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                                                                        .UserDomainMask, true)[0] as String;
    
        var plistPath : String = documentPath.stringByAppendingPathComponent("userData.plist");
        contents = NSDictionary(contentsOfFile: plistPath)!;
        
    }
}