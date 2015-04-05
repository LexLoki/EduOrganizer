//
//  AddProfessorView.swift
//  Stud
//
//  Created by Pietro Ribeiro Pepe on 4/4/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddProfessorView : UIView{
    
    var nomeText:UITextField!;
    var emailText:UITextField!;
    var subjectCode:UITextField!;
    var cancelButton:UIButton!;
    var saveButton:UIButton!;
    var addSubject:UITextField!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        let altura:CGFloat =  view.frame.height*0.08;
        
        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.075, view.frame.height*0.2, view.frame.width*0.85
            , altura*5);
        //definindo que eh a view eh a tela//
        var tela : UIView = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 7
        tela.backgroundColor = UIColor.whiteColor()
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(tela)
        
        //criando campos de texto//
        let spacing:CGFloat = area.width*0.05;
        //botao pra cancelar
        cancelButton = UIButton(frame: CGRectMake(spacing, 0, area.width*0.3, altura))
        cancelButton.backgroundColor = UIColor.whiteColor();
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        //botao pra salver
        saveButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.3, 0, area.width*0.3, altura))
        saveButton.backgroundColor = UIColor.whiteColor();
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        nomeText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura, area.width, altura))
        nomeText.autocorrectionType = UITextAutocorrectionType.No;
        nomeText.placeholder = "Name"
        
        emailText = UITextField(frame: CGRectMake(spacing, nomeText.frame.origin.y + altura, area.width, altura))
        emailText.autocorrectionType = UITextAutocorrectionType.No;
        emailText.placeholder = "e-mail"
        
        subjectCode = UITextField(frame: CGRectMake(spacing, emailText.frame.origin.y + altura, area.width, altura))
        subjectCode.placeholder = "subject code"
        subjectCode.inputView = UIPickerView()
        
        addSubject = UITextField(frame: CGRectMake(spacing, subjectCode.frame.origin.y + altura, area.width, altura))
        addSubject.placeholder = "Add more subjects"
        
        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/1, area.width, 1))
        lineView.backgroundColor = UIColor.blackColor()
        
        var lineView1 : UIView = UIView (frame: CGRectMake(0, nomeText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = UIColor.blackColor()
        var lineView2 : UIView = UIView (frame: CGRectMake(0, emailText.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = UIColor.blackColor()
        var lineView3 : UIView = UIView (frame: CGRectMake(0, subjectCode.frame.origin.y + altura/1, area.width, 1))
        lineView3.backgroundColor = UIColor.blackColor()
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        tela.addSubview(nomeText)
        tela.addSubview(emailText)
        tela.addSubview(subjectCode)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(addSubject)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)
        tela.addSubview(lineView3)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}