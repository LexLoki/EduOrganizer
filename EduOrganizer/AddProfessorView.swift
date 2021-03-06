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
    var dismissButton: UIButton!;
    var saveButton:UIButton!;
    var cameraButton:UIButton!;
    var phoneText:UITextField!;
    //var addSubject:UITextField!;
    var newLabel: UILabel!;
    var cameraImage: UIImage!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        let altura:CGFloat =  view.frame.height*0.08;
        let alturaLabel:CGFloat = view.frame.height*0.09
        
        // Blur Effect
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        
        //declaracao da area e definicao do tamanho//
        let area:CGRect = CGRectMake(view.frame.width*0.05, view.frame.height*0.2, view.frame.width*0.90
            , altura*5);
        
        //definindo que eh a view eh a tela//
        let tela : UIView = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 5
        tela.backgroundColor = UIColor.UIColorFromRGB(0xD5D9DF)
        
        dismissButton = UIButton(frame: CGRectMake(0,0, view.frame.width, view.frame.height))
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(blurView)
        view.addSubview(dismissButton)
        view.addSubview(tela)
        
        //criando campos de texto//
        let spacing:CGFloat = area.width*0.05;
        let spacingLabel: CGFloat = (blurView.frame).width*0.18
        
        newLabel = UILabel(frame: CGRectMake(spacingLabel, alturaLabel, area.width*0.7, alturaLabel/2))
        newLabel.textAlignment = NSTextAlignment.Center
        newLabel.text = "New Professor"
        newLabel.textColor = UIColor.whiteColor()
        newLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        
        //botao pra cancelar
        cancelButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.22, altura/2))
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 20)
        cancelButton.setTitleColor(UIColor.UIColorFromRGB(0x1A242E), forState: UIControlState.Normal)
        
        //botao pra salver
        saveButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.18, altura/4, area.width*0.2, altura/2))
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 20)
        saveButton.setTitleColor(UIColor.UIColorFromRGB(0x1A242E), forState: UIControlState.Normal)
        
        //botao pra imagem
        cameraButton = UIButton(frame: CGRectMake(area.width*0.5 - altura*0.35, altura*0.15, altura*0.7, altura*0.7))
        cameraImage = UIImage(named: "camera");
        cameraButton.setImage(cameraImage, forState: UIControlState.Normal);
        
        // TEXT FIELDS
        
        // Name Text Field
        
        nomeText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/1.4, area.width, altura))
        nomeText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        nomeText.autocorrectionType = UITextAutocorrectionType.No;
        nomeText.placeholder = "Name"
        
        emailText = UITextField(frame: CGRectMake(spacing, nomeText.frame.origin.y + altura, area.width, altura))
        emailText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        emailText.autocorrectionType = UITextAutocorrectionType.No;
        emailText.placeholder = "Email"
        emailText.keyboardType = UIKeyboardType.EmailAddress;
        
        phoneText = UITextField(frame: CGRectMake(spacing, emailText.frame.origin.y + altura, area.width, altura))
        phoneText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        phoneText.placeholder = "Phone";
        phoneText.keyboardType = UIKeyboardType.PhonePad;
        
        subjectCode = UITextField(frame: CGRectMake(spacing, phoneText.frame.origin.y + altura, area.width, altura))
        subjectCode.font = UIFont(name: "AvenirNext-Regular", size: 18)
        subjectCode.placeholder = "Subject code"
        subjectCode.inputView = UIPickerView()
        
//        addSubject = UITextField(frame: CGRectMake(spacing, subjectCode.frame.origin.y + altura, area.width, altura))
//        addSubject.font = UIFont(name: "AvenirNext-Regular", size: 18)
//        addSubject.autocorrectionType = UITextAutocorrectionType.No;
//        addSubject.placeholder = "Add more subjects"
        
        let lineColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        let lineView : UIView = UIView (frame: CGRectMake(0, altura/1, area.width, 1))
        lineView.backgroundColor = lineColor;
        
        let lineView1 : UIView = UIView (frame: CGRectMake(0, nomeText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = lineColor;
        
        let lineView2 : UIView = UIView (frame: CGRectMake(0, emailText.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = lineColor;
        
        let lineView3 : UIView = UIView (frame: CGRectMake(0, phoneText.frame.origin.y + altura/1, area.width, 1))
        lineView3.backgroundColor = lineColor;
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        blurView.addSubview(newLabel)
        tela.addSubview(nomeText)
        tela.addSubview(emailText)
        tela.addSubview(subjectCode)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(cameraButton)
        tela.addSubview(phoneText);
        //tela.addSubview(addSubject)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)
        tela.addSubview(lineView3)

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}