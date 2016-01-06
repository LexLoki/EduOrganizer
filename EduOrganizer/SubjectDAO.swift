//
//  SubjectDAO.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class SubjectDAO : StudDAO, ProtocolDAO {

    override func loadPList() -> NSMutableDictionary{
        var subjects : NSMutableDictionary = contents["materias"] as! NSMutableDictionary;
        return subjects;
    }
    
    @objc func getDataArray() -> Array<AnyObject> {

        var subjects : Array = Array<SubjectModel>();
        
        for (id, _) in self.loadPList(){
            
            var subject : SubjectModel = SubjectModel();
            subject = getDataById(id) as! SubjectModel;
            
            subjects.append(subject);
        }
        
        return subjects;
    }
    
    func getSubjectsByIdProfessor(id: Int) -> Array<SubjectModel>{
        
        var materias = Array<SubjectModel>();
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            if var profDict : NSDictionary = subject["professor"] as? NSDictionary{
                var idProf : String = profDict["id"] as! String;
            
                if (idProf == String(id)){
                    materias.append(self.getDataById(idKey) as! SubjectModel);
                }
            }
        }
    
        return materias;
    }
    
    @objc func getDataById(id: AnyObject) -> AnyObject {
     
        var subject : SubjectModel = SubjectModel();
        
        var subjDict : NSDictionary = self.loadPList()[id as! String] as! NSDictionary;
        
        if var profDict : NSDictionary = subjDict["professor"] as?  NSDictionary{
            var idProf : String = profDict["id"] as! String;
            subject.professor = ProfessorDAO().getDataById(idProf) as! ProfessorModel;
        }
        else{
            subject.professor = nil;
        }
        subject.id = (id) as! String;
        subject.nome = subjDict["nome"] as! String;

        //getNotes
        var notesIdArray : Array<String> = subjDict["anotacoes"] as! Array<String>;
        
        if (notesIdArray.count > 0){
            subject.notes = Array<NoteModel>();
        }
        
        var noteDAO : NoteDAO = NoteDAO();
        
        for (var i = 0; i < notesIdArray.count; i++){
            subject.notes.append(noteDAO.getDataById(notesIdArray[i]) as! NoteModel);
        }
        
        subject.tarefas = Array<TaskModel>();
        
        return subject;
    }
    
    func removePrefessorReferencesById(id: Int){
        
        var materias = Array<SubjectModel>();
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var profDict : NSDictionary = subject["professor"] as! NSDictionary;
            var idProf : String = profDict["id"] as! String;
            
            if (idProf == String(id)){
                profDict = NSDictionary();
                
                subject.setObject(profDict, forKey: "professor");
                dict.setObject(subject, forKey: idKey as! String);
            }
        }
        
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);

    }

    
    func removeReferencesById(id:AnyObject, key : String){
        
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var idArray : Array<String> = subject[key] as! Array<String>;
        
            for(var i = idArray.count-1; i >= 0; i--){
                if(idArray[i] == String(id as! Int)){
                    idArray.removeAtIndex(i);
                    break;
                }
            }
            
            subject.setObject(idArray, forKey: key);
            dict.setObject(subject, forKey: idKey as! String);
        }
        
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        
    }
    
    func removeProfRefById(id:AnyObject, key : String){
        var dict : NSMutableDictionary = loadPList();
        for(idKey, subject) in dict{
            if var idArray = subject[key] as? NSDictionary{
                if(idArray["id"] as! String == String(id as! Int)){
                    subject.removeObjectForKey(key);
                    dict.setObject(subject, forKey: idKey as! String);
                }
            }
        }
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
    }
    
    func getAvailableSubjectArray() -> Array<SubjectModel>{
        var dataArray: Array<SubjectModel> = getDataArray() as! Array<SubjectModel>;
        var size = dataArray.count
        for(var i:Int = 0; i<size; i++){
            if(dataArray[i].professor != nil){
                dataArray.removeAtIndex(i--);
                size--;
            }
        }
        return dataArray;
    }
    
    func deleteDataById(id: AnyObject) {
        
        (contents["materias"] as! NSMutableDictionary).removeObjectForKey(id);
        contents.writeToFile(plistPath, atomically: true);
    }
    
    //func saveData(object : AnyObject, )
    
    func saveData(object : AnyObject) {
        
        var subjsDict : NSMutableDictionary = self.loadPList();
        
        var subject = object as! SubjectModel;
        
        var subjDict : NSMutableDictionary = NSMutableDictionary();
        
        var newId : String = "";
        
        if (subject.id != nil){
            newId = String(subject.id);
            
            (contents["materias"] as! NSMutableDictionary).removeObjectForKey(String(subject.id));
           contents.writeToFile(plistPath, atomically: true);
            
         }else{
            newId = getFreeIdInDict(subjsDict);
         }
        
        subjDict.setValue(String.checkString(subject.nome), forKey: "nome");
        if(subject.notes == nil){
            subject.notes = Array<NoteModel>();
        }
        subjDict.setValue(subject.notes, forKey: "anotacoes");
        if(subject.professor != nil){
            let profDict = NSDictionary(objects: [String(format: "%i", subject.professor.id),subject.professor.nome], forKeys: ["id","nome"]);
            subjDict.setValue(profDict, forKey: "professor");
        }
        if(subject.tarefas == nil){
            subject.tarefas = Array<TaskModel>();
        }
        subjDict.setValue(subject.tarefas, forKey: "tarefas");
        
        subjsDict.setObject(subjDict, forKey: newId);
        contents.setObject(subjsDict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        
    }
}