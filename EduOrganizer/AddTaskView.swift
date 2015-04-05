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
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);

        //declaracao da area e definicao do tamanho//
        var area:CGRect = CGRectMake(view.frame.width*0.075, view.frame.height*0.2, view.frame.width*0.85
            , view.frame.height*0.4);
        //definindo que a view eh a tela//
        var tela : UIView = UIView(frame: area)
        //acessando uma propriedade da tela(UIView) alterando as bordas//
        tela.layer.cornerRadius = 7
        tela.backgroundColor = UIColor.whiteColor()
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(tela)
        
        //criando campos de texto/altura tem 8% da tela
        let altura:CGFloat =  view.frame.height*0.08
        let spacing:CGFloat = area.width*0.05;
        
        //botao pra cancelar
        cancelButton = UIButton(frame: CGRectMake(spacing, altura/4, area.width*0.3, altura/2))
        cancelButton.backgroundColor = UIColor.whiteColor();
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        //botao pra salvar
        saveButton = UIButton(frame: CGRectMake(area.width - spacing - area.width*0.3, altura/4, area.width*0.3, altura/2))
        saveButton.backgroundColor = UIColor.whiteColor();
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        nameText = UITextField(frame: CGRectMake(spacing, cancelButton.frame.origin.y + altura/2, area.width, altura))
        nameText.autocorrectionType = UITextAutocorrectionType.No;
        nameText.placeholder = "Name"
 
        date = UITextField(frame: CGRectMake(spacing, nameText.frame.origin.y + altura, area.width, altura))
        date.autocorrectionType = UITextAutocorrectionType.No;
        date.placeholder = "Date"

        var lineView : UIView = UIView (frame: CGRectMake(0, cancelButton.frame.origin.y + altura/2, area.width, 1))
        lineView.backgroundColor = UIColor.blackColor()
        
        var lineView1 : UIView = UIView (frame: CGRectMake(0, nameText.frame.origin.y + altura/1, area.width, 1))
        lineView1.backgroundColor = UIColor.blackColor()
        var lineView2 : UIView = UIView (frame: CGRectMake(0, date.frame.origin.y + altura/1, area.width, 1))
        lineView2.backgroundColor = UIColor.blackColor()
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        tela.addSubview(nameText)
        tela.addSubview(date)
        tela.addSubview(cancelButton)
        tela.addSubview(saveButton)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        tela.addSubview(lineView2)

}
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
}
