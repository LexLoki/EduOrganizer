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
        
        var cancelButton:UIButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.3, altura/2))
        cancelButton.backgroundColor = UIColor.whiteColor();
        cancelButton.addTarget(self, action: "cancelAction:", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/2, area.width, 1))
        lineView.backgroundColor = UIColor.blackColor()
        
        var nomeText:UITextField = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/2, area.width, altura))
        nomeText.placeholder = "Name"
        
        var emailText:UITextField = UITextField(frame: CGRectMake(spacing, nomeText.frame.origin.y + altura, area.width, altura))
        emailText.placeholder = "e-mail"
        
        var subjectCode:UITextField = UITextField(frame: CGRectMake(spacing, emailText.frame.origin.y + altura, area.width, altura))
        subjectCode.placeholder = "subject code"
        subjectCode.inputView = UIPickerView()
        
        //        CGRectMake(spacing, subjectCode.frame.origin.y + altura, area.width*0.3, altura/2)
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        tela.addSubview(nomeText)
        tela.addSubview(emailText)
        tela.addSubview(subjectCode)
        tela.addSubview(cancelButton)
        tela.addSubview(lineView)
        
    }
    //quando aperta o cancel tem que voltar pra tela anterior//
    func cancelAction(button:UIButton){
        println("Funcionou");
    }
}