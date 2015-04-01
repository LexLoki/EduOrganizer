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
        var tasks : NSMutableDictionary = contents["tarefas"] as NSMutableDictionary;
        return tasks;
    }
    
    func getDataArray() -> Array<AnyObject> {
        
        var res = setUpTasks();
        var tasks : Array = Array<TaskModel>();
        
        for (id, _) in res{
            var task : TaskModel = getDataById(id) as TaskModel;
            tasks.append(task);
        }
        
        tasks.sort({$0.data?.timeIntervalSince1970 < $1.data?.timeIntervalSince1970});
        
        return tasks;
    }
    
    func getDataById(id: AnyObject) -> AnyObject {
        
        var task : TaskModel?;
        
        var res = setUpTasks();
        var taskDict : NSDictionary = res[id as String] as NSDictionary;
        
        if (taskDict.count > 0){
            
            task = TaskModel();
            
            task?.id = (id as NSString).integerValue;
            task?.nome = taskDict["nome"] as String;
            task?.descricao = taskDict["descricao"] as String;
            task?.data = taskDict["data"] as NSDate!;
        }
        
        return task!;
    }
    
    func deleteDataById(id: AnyObject) {
        
        (contents["tarefas"] as NSMutableDictionary).removeObjectForKey(String(id as Int));
        contents.writeToFile(plistPath, atomically: true);
        
        var subjectDAO = SubjectDAO();
        subjectDAO.removeTaskReferencesById(id);

    }
    
    func saveData(object : AnyObject) {
        
        var tasksDict : NSMutableDictionary = self.loadPList();
        
        var task = object as TaskModel;
        var taskDict : NSMutableDictionary = NSMutableDictionary();
        
        var newId : String = "";
        
        if (task.id != nil && task.id > 0){
            newId = String(task.id);
            
            (contents["tarefas"] as NSMutableDictionary).removeObjectForKey(String(task.id));
            contents.writeToFile(plistPath, atomically: true);
            
        }else{
            newId = getFreeIdInDict(taskDict);
        }
        
        taskDict.setValue(task.descricao, forKey: "descricao");
        taskDict.setValue(task.nome, forKey: "nome");
        taskDict.setValue(task.data, forKey: "data");

        
        taskDict.setObject(taskDict, forKey: newId);
        contents.setObject(taskDict, forKey: "tarefas");
        contents.writeToFile(plistPath, atomically: true);
        
    }

    private func setUpTasks() -> NSMutableDictionary{
        var taskDict : NSMutableDictionary  = self.loadPList();
        
        return taskDict;
    }
    
    
}