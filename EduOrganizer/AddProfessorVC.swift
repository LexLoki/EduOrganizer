//
//  AddProfessorVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/2/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddProfessor : UIViewController {
    
    var professor: ProfessorModel = ProfessorModel();
    var addView:AddProfessorView!;
    
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
        println("Funcionou");
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){
        
        /*
        var vc = ImagePickVC();
        presentViewController(vc, animated: true, completion: nil);
        */
        
        //atribuindo as informacoes dos campos para o professor
        professor.nome = addView.nomeText.text;
        professor.email = addView.emailText.text;
        
        var profDAO = ProfessorDAO();
        profDAO.saveData(professor);
        
        dismissViewControllerAnimated(true, completion: nil);
        
        
    }

    
    //FALTA CUIDAR DE GARANTIR REFRESH NA PAGINA ABAIXO DO POPUP CASO SEJA PAGINA QUE EXIBE PROFESSORES
    //PROFESSORSVC OU STUDENTVC
    //A MELHOR MANEIRA, NA MINHA OPINIAO, É USAR NOTIFICATION NO MOMENTO DO DISMISS (COMPLETION)
    //COM OBSERVER NAS TELAS PARA DAR REFRESH

}