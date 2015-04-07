//
//  AddTaskVC.swift
//  Stud
//
//  Created by Severo & Juliana Zilberberg on 4/5/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddTaskVC : UIViewController, UITextFieldDelegate {
    
    
    var tarefa: TaskModel = TaskModel();
    var addView: AddTaskView!;
    var popDatePicker : PopDatePicker?
    
    /*
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        addView.date.text = dateFormatter.stringFromDate(sender.date)
    }
    */
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        addView = AddTaskView(view: view, parent: self);
        addView.cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addView.saveButton.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        popDatePicker = PopDatePicker(forTextField: self.addView.date)
        addView.date.delegate = self
        
    }
    override func viewDidAppear(animated: Bool) {
        println("APPEAR");
    }
    
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        println("Funcionou");
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //desabilitar o input do picker view
    func resign() {
        
        addView.nameText.resignFirstResponder()
        addView.date.resignFirstResponder()
        addView.desc.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField === addView.date) {
            resign()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .MediumStyle
            formatter.timeStyle = .NoStyle
            let initDate = NSDate()
            
            //atualiza a data no picker view
            popDatePicker!.pick(self, initDate:initDate, dataChanged: { (newDate : NSDate, forTextField : UITextField) -> () in
                
                //atualiza a data no textField
                self.addView.date.text = formatter.stringFromDate(newDate)
                
            })
            return false
        }
        else {
            return true
        }
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){
        
        //atribuindo as informacoes dos campos para tarefas
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        let finalDate = formatter.dateFromString(addView.date.text)
        
        tarefa.nome = addView.nameText.text;
        tarefa.data = finalDate;
        tarefa.descricao = addView.desc.text;
    
        
        var taskDAO = TaskDAO();
        taskDAO.saveData(tarefa);
        
        dismissViewControllerAnimated(true, completion: nil);
        
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true);
    }
    
    //FALTA CUIDAR DE GARANTIR REFRESH NA PAGINA ABAIXO DO POPUP CASO SEJA PAGINA QUE EXIBE PROFESSORES
    //PROFESSORSVC OU STUDENTVC
    //A MELHOR MANEIRA, NA MINHA OPINIAO, É USAR NOTIFICATION NO MOMENTO DO DISMISS (COMPLETION)
    //COM OBSERVER NAS TELAS PARA DAR REFRESH
    
}