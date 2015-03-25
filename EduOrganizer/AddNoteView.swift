//
//  AddNotesView.swift
//  Stud
//
//  Created by Haroldo Olivieri on 3/24/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class AddNoteView : UIView {
    
    var text: UITextView!;
    
    init(frame: CGRect, parent: UIViewController) {
        super.init(frame: frame);
    
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 18)!,
            NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        parent.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        
        var tela: CGRect = CGRect(x: frame.size.width*0.03,
                                  y: frame.size.height*0.03,
                                  width: frame.size.width*0.94,
                                  height: frame.size.height*0.82);
        
        text = UITextView(frame: tela);

        text.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        text.keyboardType = UIKeyboardType.ASCIICapable;
        text.textColor = UIColor.UIColorFromRGB(0xFFFFFF);
        text.font = UIFont (name: "Avenir Next", size: 20);

        addSubview(text!);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}