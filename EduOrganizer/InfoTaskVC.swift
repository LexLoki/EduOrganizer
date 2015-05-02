//
//  AddTaskVC.swift
//  Stud
//
//  Created by Severo & Juliana Zilberberg on 4/5/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class InfoTaskVC : UIViewController{
    
    
    var tarefa: TaskModel = TaskModel();
    var infoView: TaskInfoView!;
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
        infoView = TaskInfoView(view: view, parent: self);
        
    }
    override func viewDidAppear(animated: Bool) {
        println("APPEAR");
    }
    
    

    
    //FALTA CUIDAR DE GARANTIR REFRESH NA PAGINA ABAIXO DO POPUP CASO SEJA PAGINA QUE EXIBE PROFESSORES
    //PROFESSORSVC OU STUDENTVC
    //A MELHOR MANEIRA, NA MINHA OPINIAO, É USAR NOTIFICATION NO MOMENTO DO DISMISS (COMPLETION)
    //COM OBSERVER NAS TELAS PARA DAR REFRESH
    
}