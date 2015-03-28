//
//  Extensions.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

extension UIColor{

    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension UILabel{
    
    class func setFontStyle(label : UILabel, sizeFont : CGFloat) -> UILabel{
        
        label.font = UIFont(name: "AvenirNext-Bold", size: sizeFont);
        label.textAlignment = NSTextAlignment.Left;
        label.textColor = UIColor.whiteColor();
        
        return label;
    }
}

extension String{
    
    static func getAbrevName(str : String) -> String{
        
        var nomeArray = str.componentsSeparatedByString(" ");
        var nome : String = "";
        
        if (nomeArray.count > 0){
            var primeiroNome = nomeArray[0];
            var primeiraLetra = primeiroNome.substringToIndex(advance(primeiroNome.startIndex, 1));
            
            nome = primeiraLetra;
            
            if (nomeArray.count > 1){
                var ultimoNome = nomeArray[nomeArray.count - 1];
                var ultimaLetra = ultimoNome.substringToIndex(advance(ultimoNome.startIndex, 1));
                
                nome = nome + ultimaLetra;
            }
        }
        
        return nome;
        
    }
}
