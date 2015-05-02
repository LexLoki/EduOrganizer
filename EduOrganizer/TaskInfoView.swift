//
//  TaskInfoView.swift
//  Stud
//
//  Created by Severo on 5/2/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class TaskInfoView: UIView {
    
    var name: UILabel!
    var date: UILabel!
    var desc: UILabel!
    var dismissButton: UIButton!
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
        
        dismissButton = UIButton(frame: CGRectMake(0,0, view.frame.width, view.frame.height))
        
        //adicionando uma subview(tela) dentro da tela principal//
        view.addSubview(blurView)
        view.addSubview(dismissButton)
        view.addSubview(tela)
        
        //criando campos de texto
        
        let spacing:CGFloat = area.width*0.05;
        let spacingLabel: CGFloat = (blurView.frame).width*0.275
        
        newLabel = UILabel(frame: CGRectMake(0, view.frame.height/11.5, view.frame.width, alturaLabel/2))
        newLabel.textAlignment = NSTextAlignment.Center
        newLabel.text = "Task Information"
        newLabel.textColor = UIColor.whiteColor()
        newLabel.font = UIFont(name: "AvenirNext-Regular", size: 28)
        
        //botao pra salvar
        name = UILabel(frame: CGRectMake(0, area.height/13, area.width, area.height/6))
        name.textAlignment = NSTextAlignment.Center
        name.text = "Task Name"
        name.textColor = UIColor.UIColorFromRGB(0x1A242E)
        name.font = UIFont(name: "AvenirNext-Medium", size: 24)
        
        date = UILabel(frame: CGRectMake(0, area.height/2.65, area.width, area.height/8))
        date.textAlignment = NSTextAlignment.Center
        date.text = "24/05/2015 (22 days)"
        date.textColor = UIColor.UIColorFromRGB(0x1A242E)
        date.font = UIFont(name: "AvenirNext-Regular", size: 20)
        
        desc = UILabel(frame: CGRectMake(0, area.height/1.9, area.width, area.height/2))
        desc.textAlignment = NSTextAlignment.Center
        desc.text = ("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
        desc.textColor = UIColor.UIColorFromRGB(0x1A242E)
        desc.numberOfLines = 0
        desc.font = UIFont(name: "AvenirNext-Regular", size: 18)
        
        
        var lineView : UIView = UIView (frame: CGRectMake(0,area.height/3.45,area.width,1))
        lineView.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        var lineView1 : UIView = UIView (frame: CGRectMake(0,area.height/1.7,area.width,1))
        lineView1.backgroundColor = UIColor.UIColorFromRGB(0x979797).colorWithAlphaComponent(0.7);
        
        //adicionar a view que criei na view pra aparecer na tela principal//
        blurView.addSubview(newLabel)
        tela.addSubview(name)
        tela.addSubview(date)
        tela.addSubview(desc)
        tela.addSubview(lineView)
        tela.addSubview(lineView1)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")}
}
