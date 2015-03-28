//
//  NotesDAO.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/24/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class NoteDAO : StudDAO, ProtocolDAO {
    
    override func loadPList() -> NSMutableDictionary? {
        var notes : NSMutableDictionary = contents["anotacoes"] as NSMutableDictionary;
        return notes;
    }
    
    func getDataArray() -> Array<AnyObject> {

        var res = setUpNote();
        var notes : Array = Array<NoteModel>();
        
        for (id, _) in res.dict{
            var note : NoteModel = getDataById(id) as NoteModel;
            notes.append(note);
        }
        
        notes.sort({$0.data?.timeIntervalSince1970 > $1.data?.timeIntervalSince1970});
        
        return notes;
    }
    
    func getDataById(id: AnyObject) -> AnyObject {
        
        var note : NoteModel = NoteModel();
        
        var res = setUpNote();
        var noteDict : NSDictionary = res.dict[id as String] as NSDictionary;
        var imageArray : Array<String> = noteDict["imagens"] as Array<String>;

        if (imageArray.count > 0){
            note.imagens = Array<UIImage>();
        }
        
        for (var i = 0; i < imageArray.count; i++){
            var noteImgStr : String = res.path.stringByAppendingPathComponent(imageArray[i]);
            var image = UIImage(contentsOfFile: noteImgStr)!;
            note.imagens?.append(image);
        }
        
        note.id = (id as NSString).integerValue;
        note.nome = noteDict["nome"] as String;
        note.texto = noteDict["texto"] as String;
        note.data = noteDict["data"] as NSDate!;
        
        return note;
    }
    
    func deleteDataById(id: AnyObject) {
        
        (contents["anotacoes"] as NSMutableDictionary).removeObjectForKey(String(id as Int));
        contents.writeToFile(plistPath, atomically: true);
        
        var subjectDAO = SubjectDAO();
        subjectDAO.removeNoteReferencesById(id);
        
    }
    
    func saveData(object : AnyObject) {
     
        var notesDict : NSMutableDictionary = self.loadPList()!;
        let newId : String = getFreeIdInDict(notesDict);
        
        var noteModel = object as NoteModel;
        
        var note : NSMutableDictionary = NSMutableDictionary();
        
        note.setValue(noteModel.texto, forKey: "texto");
        note.setValue(noteModel.nome, forKey: "nome");
        note.setValue(noteModel.data, forKey: "data");
        
        var imgArray : Array<String> = Array<String>();
        if (noteModel.imagens?.count > 0){
            for (var i = 0; i < noteModel.imagens?.count; i++){
                var image : UIImage = noteModel.imagens?[i] as UIImage!;
                imgArray.append(image.accessibilityIdentifier);
            }
        }
        
        note.setValue(imgArray, forKey: "imagens");
        
        notesDict.setObject(note, forKey: newId);
        contents.setObject(notesDict, forKey: "anotacoes");
        contents.writeToFile(plistPath, atomically: true);
     
    }
    
    //get path with notes images
    private func getNotesImagePath() -> String{
        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        var imgPath : String = documentPath.stringByAppendingPathComponent("imgNote");
        
        return imgPath;
    }
    
    //setup note data
    private func setUpNote() -> (dict: NSMutableDictionary, path: String){
        var noteDict : NSMutableDictionary  = self.loadPList()!;
        var imgPath : String = getNotesImagePath();
        
        return(noteDict, imgPath);
    }
    
}