//
//  AddSubjectView.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/5/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddSubjectView : UIView{
    
    
    var nameText : UITextField!;
    var code : UITextField!;
    var professor : UITextField!;
    var tituloLabel : UILabel!;
    var cancelButton: UIButton!;
    var dismissButton: UIButton!;
    var saveButton : UIButton!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);

        let altura: CGFloat = view.frame.height*0.08
        let alturaLabel : CGFloat = view.frame.height*0.09
        
        //Blur Effect
        let blur = UIBlurEffect(style : UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        
        //declaracao da area e definicao do tamanho//
        let area:CGRect = CGRectMake(view.frame.width*0.05, view.frame.height*0.2, view.frame.width*0.90
            , altura*4);
        
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
        
        tituloLabel = UILabel(frame: CGRectMake(spacingLabel, alturaLabel, area.width*0.7, alturaLabel/2))
        tituloLabel.textAlignment = NSTextAlignment.Center
        tituloLabel.text = "New Subject"
        tituloLabel.textColor = UIColor.whiteColor()
        tituloLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        
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
        
        // Name Text Field
        
        nameText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/1.4, area.width, altura))
        nameText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        nameText.autocorrectionType = UITextAutocorrectionType.No;
        nameText.placeholder = "Name"
        
        //Code TextFiel
        code = UITextField(frame: CGRectMake(spacing, nameText.frame.origin.y + altura, area.width, altura))
        code.font = UIFont(name: "AvenirNext-Regular", size: 18)
        code.autocorrectionType = UITextAutocorrectionType.No;
        code.placeholder = "Code"
        
        //Add professor
        professor = UITextField(frame: CGRectMake(spacing, code.frame.origin.y + altura, area.width, altura))
        professor.font = UIFont(name: "AvenirNext-Regular", size: 18)
        professor.autocorrectionType = UITextAutocorrectionType.No;
        professor.placeholder = "Add a professor"
        professor.inputView = UIPickerView()
        
        
        let lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/1.4, area.width, 1))
        lineView.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        let lineView1 : UIView = UIView (frame: CGRectMake(0, nameText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        let lineView2 : UIView = UIView (frame: CGRectMake(0, code.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);

        
        //adicionar a view que criei na view pra aparecer na tela principal//
        blurView.addSubview(tituloLabel)
        tela.addSubview(nameText)
        tela.addSubview(code)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(professor)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)
        
    }
    
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")}


}