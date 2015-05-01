//
//  AddSubjectVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/7/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddSubjectVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var subject: SubjectModel = SubjectModel();
    var addView:AddSubjectView!;
    var professors: Array<ProfessorModel>!
    var selectedProfessor: ProfessorModel = ProfessorModel();
    
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        addView = AddSubjectView(view: view, parent: self);
        addView.cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        addView.saveButton.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        var professorDAO = ProfessorDAO()
        professors = professorDAO.getDataArray() as! Array<ProfessorModel>
        (addView.professor.inputView as! UIPickerView).delegate = self;
        (addView.professor.inputView as! UIPickerView).dataSource = self;

        
    }
    override func viewDidAppear(animated: Bool) {
        println("APPEAR");
    }
    
    //picker de AddProfessor
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(professors.count==0){
            return 1;
        }
        return professors.count;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(professors.count==0){
            return "No professors available";
        }
        return professors[row].nome;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row<professors.count){
            addView.professor.text = professors[row].nome;
            selectedProfessor = professors[row];
        }
    }
    
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){


    //atribuindo as informacoes dos campos
        subject.nome = addView.nameText.text;
        subject.id = addView.code.text;
        subject.professor = selectedProfessor;
        
        var subjectDAO = SubjectDAO();
        subjectDAO.saveData(subject);
        
        NSNotificationCenter.defaultCenter().postNotificationName("addedNote", object: nil);
        dismissViewControllerAnimated(true, completion: nil);
 }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true);
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true);
    }
}

