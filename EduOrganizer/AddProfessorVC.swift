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
    
    var nomeText:UITextField!;
    var emailText:UITextField!;
    var subjectCode:UITextField!;
    
    //IR PARA PARTE DE VIEW
    override func viewDidLoad(){
        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.075, view.frame.height*0.2, view.frame.width*0.85
            , view.frame.height*0.4);
        //definindo que eh a view eh a tela//
        var tela : UIView = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 8
        tela.backgroundColor = UIColor.whiteColor()
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(tela)
        
        //criando campos de texto//
        let altura:CGFloat =  area.height/5
        let spacing:CGFloat = area.width*0.05;
        
        //botao pra cancelar
        var cancelButton:UIButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.3, altura/2))
        cancelButton.backgroundColor = UIColor.whiteColor();
        cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        //botao pra salver
        var saveButton:UIButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.3, altura/4, area.width*0.3, altura/2))
        saveButton.backgroundColor = UIColor.whiteColor();
        saveButton.addTarget(self, action: "saveAction:", forControlEvents: UIControlEvents.TouchUpInside)
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/2, area.width, 1))
        lineView.backgroundColor = UIColor.blackColor()
        
       nomeText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/2, area.width, altura))
        nomeText.placeholder = "Name"
        
        emailText = UITextField(frame: CGRectMake(spacing, nomeText.frame.origin.y + altura, area.width, altura))
        emailText.placeholder = "e-mail"
        
        subjectCode = UITextField(frame: CGRectMake(spacing, emailText.frame.origin.y + altura, area.width, altura))
        subjectCode.placeholder = "subject code"
        subjectCode.inputView = UIPickerView()
        
        //        CGRectMake(spacing, subjectCode.frame.origin.y + altura, area.width*0.3, altura/2)
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        tela.addSubview(nomeText)
        tela.addSubview(emailText)
        tela.addSubview(subjectCode)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(lineView)
        
    }
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        println("Funcionou");
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    //quando aperto o save salva na plist//
    func saveAction(button:UIButton){
        println("Salvou");
        
        //atribuindo as informacoes dos campos para o professor
        professor.nome = nomeText.text;
        professor.email = emailText.text;
        
        var profDAO = ProfessorDAO();
        profDAO.saveData(professor);
        
        dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    //FALTA CUIDAR DE GARANTIR REFRESH NA PAGINA ABAIXO DO POPUP CASO SEJA PAGINA QUE EXIBE PROFESSORES
    //PROFESSORSVC OU STUDENTVC
    //A MELHOR MANEIRA, NA MINHA OPINIAO, É USAR NOTIFICATION NO MOMENTO DO DISMISS (COMPLETION)
    //COM OBSERVER NAS TELAS PARA DAR REFRESH

}