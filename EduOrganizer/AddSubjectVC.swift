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
    private var professors: Array<ProfessorModel>!
    var selectedProfessor: ProfessorModel!;
    
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        addView = AddSubjectView(view: view, parent: self);
        
        addView.cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addView.saveButton.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addView.dismissButton.addTarget(self, action: "dismiss:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let professorDAO = ProfessorDAO()
        professors = professorDAO.getDataArray() as! Array<ProfessorModel>
        (addView.professor.inputView as! UIPickerView).delegate = self;
        (addView.professor.inputView as! UIPickerView).dataSource = self;        
    }
    override func viewDidAppear(animated: Bool) {
        print("APPEAR");
    }
    
    //picker de AddProfessor
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(professors.count==0){
            return 1;
        }
        return professors.count + 1;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(professors.count==0){
            return "No professors available";
        }
        if(row == 0){
            return "No professor";
        }
        return professors[row-1].nome;
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            if professors.count != 0{
                addView.professor.text = "";
                selectedProfessor = nil;
            }
        }
        //if(row<professors.count){
        else{
            addView.professor.text = professors[row-1].nome;
            selectedProfessor = professors[row-1];
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
        
        if(!subject.nome.isEmpty && !subject.id.isEmpty){
            let subjectDAO = SubjectDAO();
            subjectDAO.saveData(subject);
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("addedNote", object: nil);
        dismissViewControllerAnimated(true, completion: nil);
 }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true);
    }
    
    func dismiss (sender: UIButton){
        print("dismiss")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true);
    }
}

