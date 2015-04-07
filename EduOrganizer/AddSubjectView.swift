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
    var startDate : UITextField!;
    var endDate : UITextField!;
    var schedule : UITextField!;
    var professor : UITextField!;
    var tituloLabel : UILabel!;
    var cancelButton: UIButton!;
    var saveButton : UIButton!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);

        let altura: CGFloat = view.frame.height*0.08
        let alturaLabel : CGFloat = view.frame.height*0.09
        
        //Blur Effect
        var blur = UIBlurEffect(style : UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        
        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.07, view.frame.height*0.2, view.frame.width*0.90
            , altura*7);
        
        //definindo que eh a view eh a tela//
        var tela : UIView = UIView(frame: area)
        
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 5
        tela.backgroundColor = UIColor.UIColorFromRGB(0xD5D9DF)
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(blurView)
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

        //Start Date
        startDate = UITextField(frame: CGRectMake(spacing, code.frame.origin.y + altura, area.width, altura))
        startDate.font = UIFont(name: "AvenirNext-Regular", size: 18)
        startDate.placeholder = "Start Date"
        startDate.inputView = UIPickerView()
        
        //End Date TextField
        endDate = UITextField(frame: CGRectMake(spacing, startDate.frame.origin.y + altura, area.width, altura))
        endDate.font = UIFont(name: "AvenirNext-Regular", size: 18)
        endDate.placeholder = "End Date"
        endDate.inputView = UIPickerView()
        
        //Add schedule
        schedule = UITextField(frame: CGRectMake(spacing, endDate.frame.origin.y + altura, area.width, altura))
        schedule.font = UIFont(name: "AvenirNext-Regular", size: 18)
        schedule.placeholder = "Add schedule"
        
        //Add professor
        professor = UITextField(frame: CGRectMake(spacing, schedule.frame.origin.y + altura, area.width, altura))
        professor.font = UIFont(name: "AvenirNext-Regular", size: 18)
        professor.placeholder = "Add a professor"
        
        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/1.4, area.width, 1))
        lineView.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView1 : UIView = UIView (frame: CGRectMake(0, nameText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView2 : UIView = UIView (frame: CGRectMake(0, code.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView3 : UIView = UIView (frame: CGRectMake(0, startDate.frame.origin.y + altura/1, area.width, 1))
        lineView3.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView4 : UIView = UIView (frame: CGRectMake(0, endDate.frame.origin.y + altura/1, area.width, 1))
        lineView4.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView5 : UIView = UIView (frame: CGRectMake(0, schedule.frame.origin.y + altura/1, area.width, 1))
        lineView5.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);

        
        //adicionar a view que criei na view pra aparecer na tela principal//
        blurView.addSubview(tituloLabel)
        tela.addSubview(nameText)
        tela.addSubview(code)
        tela.addSubview(startDate)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(endDate)
        tela.addSubview(schedule)
        tela.addSubview(professor)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)
        tela.addSubview(lineView3)
        tela.addSubview(lineView4)
        tela.addSubview(lineView5)
        
    }
    
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")}


}