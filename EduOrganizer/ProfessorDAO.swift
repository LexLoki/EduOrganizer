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
        var professors : NSMutableDictionary = contents["professores"] as! NSMutableDictionary;
        return professors;
    }
    
    //returns an array with all professors (ProfessorModel)
    @objc func getDataArray() -> Array<AnyObject>{
        
        var res = setUpProfessor();
        var professors : Array = Array<ProfessorModel>();
        
        for (id, _) in res.dict{
            
            var professor : ProfessorModel = getDataById(id) as! ProfessorModel;
            professors.append(professor);
        }
        
        return professors;
    }
    
    //get populated instance of ProfessorModel by Id
    @objc func getDataById(id : AnyObject) -> AnyObject{
        
        var professor : ProfessorModel = ProfessorModel();
        
        var res = setUpProfessor();
        var prof : NSDictionary = res.dict[id as! String] as! NSDictionary;

        professor.id = (id as! NSString).integerValue;
        professor.nome = prof["nome"] as! String;
        professor.email = prof["e-mail"] as! String;
        professor.telefone = prof["telefone"] as! String;
        
        if(!(prof["imagem"] as! String).isEmpty){
            var profImg : String = res.path.stringByAppendingPathComponent(prof["imagem"] as! String);
            professor.imagem = profImg;
        }
        
        return professor;
    }
    
    func saveData(object : AnyObject) {
        
        var profsDict : NSMutableDictionary = self.loadPList()!;
        var profDict : NSMutableDictionary = NSMutableDictionary();
        
        var professor = object as! ProfessorModel;
        
        var newId : String = "";
        if (professor.id != nil){
            newId = String(professor.id);
            
            (contents["professores"] as! NSMutableDictionary).removeObjectForKey(String(professor.id));
            contents.writeToFile(plistPath, atomically: true);
            
        }else{
            newId = getFreeIdInDict(profsDict);
        }
        
        profDict.setValue(String.checkString(professor.nome), forKey: "nome");
        profDict.setValue(String.checkString(professor.email), forKey: "e-mail");
        profDict.setValue(String.checkString(professor.telefone), forKey: "telefone");
        
        if(professor.imagem == nil){
            profDict.setValue("", forKey: "imagem");
        }else{
            profDict.setValue(professor.imagem, forKey: "imagem");
        }
        
        profsDict.setObject(profDict, forKey: newId);
        contents.setObject(profsDict, forKey: "professores");
        contents.writeToFile(plistPath, atomically: true);
        
    }
    
    func deleteDataById(id: AnyObject) {
        
        var imgPath = getProfessorsImagePath().stringByAppendingPathComponent(((contents["professores"] as! NSDictionary)[String(id as! Int)] as! NSDictionary)["imagem"] as! String);
        NSFileManager.defaultManager().removeItemAtPath(imgPath, error: nil);
        (contents["professores"] as! NSMutableDictionary).removeObjectForKey(String(id as! Int));
        contents.writeToFile(plistPath, atomically: true);
        
        SubjectDAO().removeProfRefById(id, key: "professor");
        //DELETAR IMAGENS DA PASTA DE imgNotes
    }
    
    func copyImgToDocuments(img : UIImage) -> String{
        var imgPath : String = getProfessorsImagePath();
        var id = getFreeIdInDict(getImgDictionary());
        id = id.stringByAppendingFormat(".png");
        imgPath = imgPath.stringByAppendingPathComponent(id);
        UIImagePNGRepresentation(img).writeToFile(imgPath, atomically: true);
        return id;
    }

    
    private func getImgDictionary() -> NSMutableDictionary{
        var imgPath : String = getProfessorsImagePath();
        var contentsArray : NSArray = NSFileManager.defaultManager().contentsOfDirectoryAtPath(imgPath, error: nil)!;
        var imgDict:NSMutableDictionary = NSMutableDictionary();
        for (var id) in contentsArray{
            let str:String = imgPath.stringByAppendingPathComponent(id as! String);
            id = id.substringToIndex(count(id as! String) - 4);
            if let img = UIImage(contentsOfFile: str){
                imgDict.setObject(img, forKey: id as! String);
            }
        }
        return imgDict;
    }
    
    //function to set empty strings instead of nil
    
    
    //get path with professors images
    private func getProfessorsImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
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