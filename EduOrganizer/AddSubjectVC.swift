//
//  AddSubjectVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/7/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddSubjectVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var subject: SubjectModel = SubjectModel();
    var addView:AddSubjectView!;
    
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        addView = AddSubjectView(view: view, parent: self);
        addView.cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addView.saveButton.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    override func viewDidAppear(animated: Bool) {
        println("APPEAR");
    }
    
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){


    //atribuindo as informacoes dos campos 
//    subject.name = addView.nameText.text;
//    subject.code = addView.code.text;
    
//    var profDAO = SubjectDAO();
//    subjDAO.saveData(subject);
    
//    NSNotificationCenter.defaultCenter().postNotificationName("addedNote", object: nil);
//    dismissViewControllerAnimated(true, completion: nil);
    //*/
 }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true);
    }
}

