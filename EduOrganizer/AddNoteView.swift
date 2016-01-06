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
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
    
        var tela: CGRect = CGRect(x: 0,
                                  y: 0,
                                  width: frame.size.width,
                                  height: CGRect.getVisibleHeight(frame, vc: parent));
        
        text = UITextView(frame: tela);
        
        text.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        text.keyboardType = UIKeyboardType.ASCIICapable;
        text.autocorrectionType = UITextAutocorrectionType.No;
        text.textColor = UIColor.UIColorFromRGB(0xFFFFFF);
        text.font = UIFont (name: "Avenir Next", size: 20);
        text.scrollEnabled = true;
        text.textContainerInset = UIEdgeInsetsMake(20, 10, 0, 0);
        //text.backgroundColor = UIColor.redColor();
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1E3044);
        view.addSubview(text);
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}