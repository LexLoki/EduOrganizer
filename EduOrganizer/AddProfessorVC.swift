//
//  AddProfessorVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/2/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddProfessorVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var professor: ProfessorModel = ProfessorModel();
    var addView:AddProfessorView!;
    var profImg: UIImage!;
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        addView = AddProfessorView(view: view, parent: self);
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
        
        /*
        var vc:UIImagePickerController = ImagePickVC();
        vc.delegate = self;
        presentViewController(vc, animated: true, completion: nil);
        */
        
        ///*
        //atribuindo as informacoes dos campos para o professor
        professor.nome = addView.nomeText.text;
        professor.email = addView.emailText.text;
        
        var profDAO = ProfessorDAO();
        profDAO.saveData(professor);
        
        NSNotificationCenter.defaultCenter().postNotificationName("addedNote", object: nil);
        dismissViewControllerAnimated(true, completion: nil);
        //*/
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        profImg = info[UIImagePickerControllerOriginalImage] as UIImage;
        picker.dismissViewControllerAnimated(true, completion: nil);
    }

}