//
//  ProfessorController.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class ProfessorController {
    
    //get Dictionary with professors
    func loadPListProfessors() -> NSMutableDictionary{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        var plistPath : String = documentPath.stringByAppendingPathComponent("userData.plist");
        let contents : NSDictionary = NSDictionary(contentsOfFile: plistPath)!;
        var professors : NSMutableDictionary = contents["professores"] as NSMutableDictionary;
        
        return professors;
        
    }
    //get path with professors images
    func getProfessorsImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgProf");
        
        return imgPath;
    }
    
    func loadProfessorData() -> (dict: NSMutableDictionary, path: String){
        var professorsDict : NSMutableDictionary  = loadPListProfessors();
        var imgPath : String = getProfessorsImagePath();
        
        return(professorsDict, imgPath);
    }
    
    //returns an array with all professors (ProfessorModel)
    func loadProfessors() -> NSMutableArray {
        
        var res = loadProfessorData();
        var professors : NSMutableArray = NSMutableArray();
        
        for (id, _) in res.dict{
            
            var professor : ProfessorModel = ProfessorModel();
            professor = getProfessorById(id, dict: res.dict, path: res.path);
            
            professors.addObject(professor);
        }
        
        return professors;
    }
    
    //get populated instance of ProfessorModel by Id
    func getProfessorById( id : AnyObject, dict : NSDictionary, path : String ) -> ProfessorModel{
        
        var prof : NSDictionary = dict[id as String] as NSDictionary;
        
        var professor : ProfessorModel = ProfessorModel();
        var profImg : String = path.stringByAppendingPathComponent(prof["imagem"] as String);
        
        professor.id = (id as NSString).integerValue;
        professor.nome = prof["nome"] as String;
        professor.email = prof["e-mail"] as String;
        professor.telefone = prof["telefone"] as String;
        professor.imagem = UIImage(contentsOfFile:profImg)!;
        //professor.materia = prof["materia"] as Int;
        
        return professor;
        
    }
}