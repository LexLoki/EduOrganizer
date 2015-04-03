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
        var subjects : NSMutableDictionary = contents["materias"] as NSMutableDictionary;
        return subjects;
    }
    
    func getDataArray() -> Array<AnyObject> {

        var subjects : Array = Array<SubjectModel>();
        
        for (id, _) in self.loadPList(){
            
            var subject : SubjectModel = SubjectModel();
            subject = getDataById(id) as SubjectModel;
            
            subjects.append(subject);
        }
        
        return subjects;
    }
    
    func getSubjectsByIdProfessor(id: Int) -> Array<SubjectModel>{
        
        var materias = Array<SubjectModel>();
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var profDict : NSDictionary = subject["professor"] as NSDictionary;
            var idProf : String = profDict["id"] as String;
            
            if (idProf == String(id)){
                materias.append(self.getDataById(idKey) as SubjectModel);
            }
        }
    
        return materias;
    }
    
    func getDataById(id: AnyObject) -> AnyObject {
     
        var subject : SubjectModel = SubjectModel();
        
        var subjDict : NSDictionary = self.loadPList()[id as String] as NSDictionary;
        var profDict : NSDictionary = subjDict["professor"] as NSDictionary;
        var idProf : String = profDict["id"] as String;
        
        subject.id = (id as NSString);
        subject.nome = subjDict["nome"] as String;
        subject.professor = ProfessorDAO().getDataById(idProf) as ProfessorModel;

        //getNotes
        var notesIdArray : Array<String> = subjDict["anotacoes"] as Array<String>;
        
        if (notesIdArray.count > 0){
            subject.notes = Array<NoteModel>();
        }
        
        var noteDAO : NoteDAO = NoteDAO();
        
        for (var i = 0; i < notesIdArray.count; i++){
            subject.notes.append(noteDAO.getDataById(notesIdArray[i]) as NoteModel);
        }
        
        subject.tarefas = Array<TaskModel>();
        
        return subject;
    }
    
    func removePrefessorReferencesById(id: Int){
        
        var materias = Array<SubjectModel>();
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var profDict : NSDictionary = subject["professor"] as NSDictionary;
            var idProf : String = profDict["id"] as String;
            
            if (idProf == String(id)){
                profDict = NSDictionary();
                
                subject.setObject(profDict, forKey: "professor");
                dict.setObject(subject, forKey: idKey as String);
            }
        }
        
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);

    }

    
    func removeReferencesById(id:AnyObject, key : String){
        
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var idArray : Array<String> = subject[key] as Array<String>;
            
            for(var i = idArray.count-1; i >= 0; i--){
                if(idArray[i] == String(id as Int)){
                    idArray.removeAtIndex(i);
                    break;
                }
            }
            
            subject.setObject(idArray, forKey: key);
            dict.setObject(subject, forKey: idKey as String);
        }
        
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        
    }
    
    func saveData(object : AnyObject) {
        
        var subjsDict : NSMutableDictionary = self.loadPList();
        
        var subject = object as SubjectModel;
        
        var subjDict : NSMutableDictionary = NSMutableDictionary();
        
        var newId : String = "";
        
        if (subject.id != nil){
            newId = String(subject.id);
            
            (contents["materias"] as NSMutableDictionary).removeObjectForKey(String(subject.id));
           contents.writeToFile(plistPath, atomically: true);
            
         }else{
            newId = getFreeIdInDict(subjsDict);
         }
        
        subjDict.setValue(String.checkString(subject.nome), forKey: "nome");
        subjDict.setValue(subject.notes, forKey: "anotacoes");
        subjDict.setValue(subject.professor, forKey: "professor");
        subjDict.setValue(subject.tarefas, forKey: "tarefas");
        
        subjDict.setObject(subjDict, forKey: newId);
        contents.setObject(subjDict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        
    }
}