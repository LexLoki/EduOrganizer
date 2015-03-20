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
    func getDataArray() -> NSMutableArray;
    func getDataById(id : AnyObject, dict : NSDictionary, path : String ) -> ProfessorModel;
    
}

class ProtocolPListDAO  {

}