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
        addView.cameraButton.addTarget(self, action: "imageAction:", forControlEvents: UIControlEvents.TouchUpInside)
        //addView.cameraButton.addTarget(self, action: "keepHighlight:", forControlEvents: UIControlEvents.TouchDragExit)
    }
    override func viewDidAppear(animated: Bool) {
        println("APPEAR");
    }
    
    func keepHighlight(button:UIButton){
        if(profImg != nil){
            button.selected = true
        }
    }
    
    //quando aperto o botao da camera vou para o rolo
    func imageAction(button:UIButton){
        var vc:UIImagePickerController = ImagePickVC();
        vc.delegate = self;
        presentViewController(vc, animated: true, completion: nil);
    }
    
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){
        
        ///*
        //atribuindo as informacoes dos campos para o professor
        professor.nome = addView.nomeText.text;
        professor.email = addView.emailText.text;
        
        var profDAO = ProfessorDAO();
        if(profImg != nil){
            professor.imagem = profDAO.copyImgToDocuments(profImg);
        }
        profDAO.saveData(professor);
        
        NSNotificationCenter.defaultCenter().postNotificationName("addedNote", object: nil);
        dismissViewControllerAnimated(true, completion: nil);
        //*/
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        profImg = info[UIImagePickerControllerOriginalImage] as UIImage;
        addView.cameraButton.selected = true;
        addView.cameraButton.setImage(profImg, forState: UIControlState.Selected);
        addView.cameraButton.setImage(profImg, forState: UIControlState.Normal);
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        profImg = nil;
        addView.cameraButton.selected = false;
        addView.cameraButton.setImage(addView.cameraImage, forState: UIControlState.Normal);
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true);
    }
}