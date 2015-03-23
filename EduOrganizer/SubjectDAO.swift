//
//  SubjectDAO.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class SubjectDAO : StudDAO, ProtocolDAO {

    func loadPList() -> NSMutableDictionary {

        var subjects : NSMutableDictionary = contents["materias"] as NSMutableDictionary;
        return subjects;

    }
    
    func getDataArray() -> Array<AnyObject> {

        var subjects : Array = Array<SubjectModel>();
        
        for (id, _) in loadPList(){
            
            var subject : SubjectModel = SubjectModel();
            subject = getDataById(id) as SubjectModel;
            
            subjects.append(subject);
        }
        
        return subjects;
    }
    
    func getDataById(id: AnyObject) -> AnyObject {
     
        var subject : SubjectModel = SubjectModel();
        
        var subjDict : NSDictionary = loadPList()[id as String] as NSDictionary;
        var profDict : NSDictionary = subjDict["professor"] as NSDictionary;
        var idProf : String = profDict["id"] as String;
        
        subject.id = (id as NSString);
        subject.nome = subjDict["nome"] as String;
        subject.professor = ProfessorDAO().getDataById(idProf) as ProfessorModel;
        
        //subject.notes FAZER
        //subject.tarefas FAZER
        
        return subject;
        
    }
    
}