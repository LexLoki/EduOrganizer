//
//  AddTask.swift
//  Stud
//
//  Created by Juliana Zilberberg on 4/5/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddTaskView : UIView {
    
    var nameText:UITextField!
    var date : UITextField!
    var subject : UITextField!
    var cancelButton:UIButton!
    var saveButton : UIButton!
    var newLabel: UILabel!
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        let altura:CGFloat =  view.frame.height*0.08
        let alturaLabel:CGFloat = view.frame.height*0.09
        
        // Blur Effect
        var blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurView = UIVisualEffectView(effect: blur)
        blurView.frame = view.bounds
        
        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.05, view.frame.height*0.2, view.frame.width*0.90
            , altura*4);
        //definindo que a view eh a tela//
        var tela : UIView = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 5
        tela.backgroundColor = UIColor.UIColorFromRGB(0xD5D9DF)
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(blurView)
        view.addSubview(tela)
        
        
        // Criando Label (New Task)
        
        
        
        //criando campos de texto
        
        let spacing:CGFloat = area.width*0.05;
        let spacingLabel: CGFloat = (blurView.frame).width*0.275
        
        newLabel = UILabel(frame: CGRectMake(spacingLabel, alturaLabel, area.width*0.5, alturaLabel/2))
        newLabel.textAlignment = NSTextAlignment.Center
        newLabel.text = "New Task"
        newLabel.textColor = UIColor.whiteColor()
        newLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        
        //botao pra cancelar
        cancelButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.22, altura/2))
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 20)
        cancelButton.setTitleColor(UIColor.UIColorFromRGB(0x1A242E), forState: UIControlState.Normal)
        
        //botao pra salvar
        saveButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.18, altura/4, area.width*0.2, altura/2))
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.titleLabel!.font = UIFont(name: "AvenirNext-Medium", size: 20)
        saveButton.setTitleColor(UIColor.UIColorFromRGB(0x1A242E), forState: UIControlState.Normal)
        
        // TEXT FIELDS
        
        // Name Text Field
        nameText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/1.4, area.width, altura))
        nameText.font = UIFont(name: "AvenirNext-Regular", size: 18)
        nameText.autocorrectionType = UITextAutocorrectionType.No;
        nameText.placeholder = "Name"
        
        // Date Text Field
        date = UITextField(frame: CGRectMake(spacing, nameText.frame.origin.y + altura/1, area.width, altura))
        date.font = UIFont(name: "AvenirNext-Regular", size: 18)
        date.autocorrectionType = UITextAutocorrectionType.No;
        date.placeholder = "Date"
        
        // Subject Text Field
        subject = UITextField(frame: CGRectMake(spacing, date.frame.origin.y + altura/1, area.width, altura))
        subject.font = UIFont(name: "AvenirNext-Regular", size: 18)
        subject.autocorrectionType = UITextAutocorrectionType.No;
        subject.placeholder = "Subject"

        
        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/1.4, area.width, 1))
        lineView.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView1 : UIView = UIView (frame: CGRectMake(0, nameText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView2 : UIView = UIView (frame: CGRectMake(0, date.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        blurView.addSubview(newLabel)
        tela.addSubview(nameText)
        tela.addSubview(date)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(subject)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)

}
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
}
