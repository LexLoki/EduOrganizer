//
//  TaskDAO.swift
//  Stud
//
//  Created by Severo & Haroldo Olivieri on 3/31/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//


import Foundation

class TaskDAO : StudDAO, ProtocolDAO{
    
    
    override func loadPList() -> NSMutableDictionary{
        var tasks : NSMutableDictionary = contents["tarefas"] as! NSMutableDictionary;
        return tasks;
    }
    
    @objc func getDataArray() -> Array<AnyObject> {
        
        var tasks : Array = Array<TaskModel>();
        
        for (id, _) in self.loadPList(){
            var task : TaskModel = getDataById(id) as! TaskModel;
            tasks.append(task);
        }
        
        tasks.sort({$0.data?.timeIntervalSince1970 < $1.data?.timeIntervalSince1970});
        
        return tasks;
    }
    
    @objc func getDataById(id: AnyObject) -> AnyObject {
        
        var task : TaskModel?;
        
        var taskDict : NSDictionary = self.loadPList()[id as! String] as! NSDictionary;
        
        if (taskDict.count > 0){
            
            task = TaskModel();
            
            task?.id = (id as! NSString).integerValue;
            task?.nome = taskDict["nome"] as! String;
            task?.descricao = taskDict["descricao"] as! String;
            task?.data = taskDict["data"] as! NSDate;
        }
        
        return task!;
    }
    
    func deleteDataById(id: AnyObject) {
        
        (contents["tarefas"] as! NSMutableDictionary).removeObjectForKey(String(id as! Int));
        contents.writeToFile(plistPath, atomically: true);
        
        SubjectDAO().removeReferencesById(id, key : "tarefas");

    }
    
    func saveData(object : AnyObject) {
        
        var tasksDict : NSMutableDictionary = self.loadPList();
        
        var task = object as! TaskModel;
        var taskDict : NSMutableDictionary = NSMutableDictionary();
        
        var newId : String = "";
        
        if (task.id != nil){
            newId = String(task.id);
            
            (contents["tarefas"] as! NSMutableDictionary).removeObjectForKey(String(task.id));
            contents.writeToFile(plistPath, atomically: true);
            
        }else{
            newId = getFreeIdInDict(tasksDict);
        }
        
        
        taskDict.setValue(task.descricao, forKey: "descricao");
        taskDict.setValue(task.nome, forKey: "nome");
        taskDict.setValue(task.data, forKey: "data");

        
        tasksDict.setObject(taskDict, forKey: newId);
        contents.setObject(tasksDict, forKey: "tarefas");
        contents.writeToFile(plistPath, atomically: true);
        
    }
}