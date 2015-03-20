//
//  ProfessorController.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class ProfessorDAO : ProtocolDAO {
    
    //load plist into a Dictionary
    func loadPList() -> NSMutableDictionary {
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        var plistPath : String = documentPath.stringByAppendingPathComponent("userData.plist");
        let contents : NSDictionary = NSDictionary(contentsOfFile: plistPath)!;
        var professors : NSMutableDictionary = contents["professores"] as NSMutableDictionary;
        
        return professors;
    }
    
    //returns an array with all professors (ProfessorModel)
    func getDataArray() -> NSMutableArray {
        
        var res = setUpProfessor();
        var professors : NSMutableArray = NSMutableArray();
        
        for (id, _) in res.dict{
            
            var professor : ProfessorModel = ProfessorModel();
            professor = getDataById(id, dict: res.dict, path: res.path);
            
            professors.addObject(professor);
        }
        
        return professors;
    }
    
    //get populated instance of ProfessorModel by Id
    func getDataById( id : AnyObject, dict : NSDictionary, path : String ) -> ProfessorModel{
        
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
    
    //get path with professors images
    private func getProfessorsImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgProf");
        
        return imgPath;
    }
    
    //setup professor data
    private func setUpProfessor() -> (dict: NSMutableDictionary, path: String){
        var professorsDict : NSMutableDictionary  = loadPList();
        var imgPath : String = getProfessorsImagePath();
        
        return(professorsDict, imgPath);
    }
}