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
    
    func removeTaskReferencesById(id:AnyObject){
        
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var tasksIdArray : Array<String> = subject["tarefas"] as Array<String>;
            
            for(var i = tasksIdArray.count-1; i >= 0; i--){
                println(i);
                
                if(tasksIdArray[i] == String(id as Int)){
                    println("gotcha");
                    tasksIdArray.removeAtIndex(i);
                    break;
                }
                
            }
            
            subject.setObject(tasksIdArray, forKey: "tarefas");
            dict.setObject(subject, forKey: idKey as String);
        }
    }

    
    func removeNoteReferencesById(id:AnyObject){
        
        var dict : NSMutableDictionary = loadPList();
        
        for (idKey, subject) in dict{
            
            var notesIdArray : Array<String> = subject["anotacoes"] as Array<String>;
            
            for(var i = notesIdArray.count-1; i >= 0; i--){
                println(i);
                
                if(notesIdArray[i] == String(id as Int)){
                    println("gotcha");
                    notesIdArray.removeAtIndex(i);
                    break;
                }
                
            }
            
            subject.setObject(notesIdArray, forKey: "anotacoes");
            dict.setObject(subject, forKey: idKey as String);
        }
        
        contents.setObject(dict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        }
    
    //***********************************************
    // TODO: Finalizar (Save Data)                  *
    //***********************************************
    
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
        
        
        subjDict.setValue(subject.nome, forKey: "nome");
        subjDict.setValue(subject.notes, forKey: "anotacoes");
        subjDict.setValue(subject.professor, forKey: "professor");
        subjDict.setValue(subject.tarefas, forKey: "tarefas");
        
        
        subjDict.setObject(subjDict, forKey: newId);
        contents.setObject(subjDict, forKey: "materias");
        contents.writeToFile(plistPath, atomically: true);
        
    }
}