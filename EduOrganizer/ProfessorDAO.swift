//
//  ProfessorController.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class ProfessorDAO : StudDAO, ProtocolDAO {
    
    //load plist into a Dictionary
    override func loadPList() -> NSMutableDictionary?{
        var professors : NSMutableDictionary = contents["professores"] as NSMutableDictionary;
        return professors;
    }
    
    //returns an array with all professors (ProfessorModel)
    func getDataArray() -> Array<AnyObject>{
        
        var res = setUpProfessor();
        var professors : Array = Array<ProfessorModel>();
        
        for (id, _) in res.dict{
            
            var professor : ProfessorModel = getDataById(id) as ProfessorModel;
            professors.append(professor);
        }
        
        return professors;
    }
    
    //get populated instance of ProfessorModel by Id
    func getDataById(id : AnyObject) -> AnyObject{
        
        var professor : ProfessorModel = ProfessorModel();
        
        var res = setUpProfessor();
        var prof : NSDictionary = res.dict[id as String] as NSDictionary;
        var profImg : String = res.path.stringByAppendingPathComponent(prof["imagem"] as String);
        
        professor.id = (id as NSString).integerValue;
        professor.nome = prof["nome"] as String;
        professor.email = prof["e-mail"] as String;
        professor.telefone = prof["telefone"] as String;
        professor.imagem = UIImage(contentsOfFile:profImg)!;
        //professor.materia = prof["materia"] as Int;
        
        return professor;
    }
    //***********************************************
    // TODO: Finalizar (Save Image)                 *
    //***********************************************
    
    func saveData(object : AnyObject) {
        
        var profsDict : NSMutableDictionary = self.loadPList()!;
        
        var professor = object as ProfessorModel;
        
        var profDict : NSMutableDictionary = NSMutableDictionary();
        
        var newId : String = "";
        
        if (professor.id != nil){
            newId = String(professor.id);
            
            (contents["professores"] as NSMutableDictionary).removeObjectForKey(String(professor.id));
            contents.writeToFile(plistPath, atomically: true);
            
        }else{
            newId = getFreeIdInDict(profDict);
        }
        
        
        profDict.setValue(professor.nome, forKey: "nome");
        profDict.setValue(professor.email, forKey: "e-mail");
        profDict.setValue(professor.telefone, forKey: "telefone");
        profDict.setValue(professor.materias, forKey: "materias");
        
        
        profDict.setObject(profDict, forKey: newId);
        contents.setObject(profDict, forKey: "professores");
        contents.writeToFile(plistPath, atomically: true);
        
    }
    
    //get path with professors images
    private func getProfessorsImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgProf");
        
        return imgPath;
    }
    
    //setup professor data
    private func setUpProfessor() -> (dict: NSMutableDictionary, path: String){
        var professorsDict : NSMutableDictionary  = self.loadPList()!;
        var imgPath : String = getProfessorsImagePath();
        
        return(professorsDict, imgPath);
    }
}