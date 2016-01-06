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

extension CGRect{
    static func getVisibleHeight(frame:CGRect, vc : UIViewController) -> CGFloat{
        var tam:CGFloat = frame.height;
        if(vc.navigationController?.navigationBar != nil){
            tam -= vc.navigationController!.navigationBar.frame.size.height;
        }
        
        if(vc.tabBarController?.tabBar != nil){
            tam -= vc.tabBarController!.tabBar.frame.height;
        }
        return tam;
    }
}


extension UILabel{
    
    class func setFontStyleBold(label : UILabel, sizeFont : CGFloat) -> UILabel{
        
        label.font = UIFont(name: "AvenirNext-Bold", size: sizeFont);
        label.textAlignment = NSTextAlignment.Left;
        label.textColor = UIColor.whiteColor();
        
        return label;
    }
    
    class func setFontStyle(label : UILabel, sizeFont : CGFloat) -> UILabel{
        
        label.font = UIFont(name: "Avenir Next", size: sizeFont);
        label.textAlignment = NSTextAlignment.Left;
        label.textColor = UIColor.whiteColor();
        
        return label;
    }
}

extension String{
    
    static func checkString(myString: String!) -> String{
        if(myString == nil){
            return "";
        }
        return myString;
    }
    
    static func getAbrevName(str : String) -> String{
        
        var nomeArray = str.componentsSeparatedByString(" ");
        var nome : String = "";
        
        if (nomeArray.count > 0){
            let primeiroNome = nomeArray[0];
            
            //CHECK for 2.0
            let primeiraLetra = (primeiroNome as NSString).substringToIndex(1);
            //var primeiraLetra = primeiroNome.substringToIndex(advance(primeiroNome.startIndex, 1));
            
            nome = primeiraLetra;
            
            if (nomeArray.count > 1){
                let ultimoNome = nomeArray[nomeArray.count - 1];
                //CHECK for 2.0
                let ultimaLetra = (ultimoNome as NSString).substringToIndex(1);
                //var ultimaLetra = ultimoNome.substringToIndex(advance(ultimoNome.startIndex, 1));
                
                nome = nome + ultimaLetra;
            }
        }
        
        return nome.uppercaseString;
        
    }
}

extension UIImage{
    
    public func getBestSquareImg() -> UIImage{
        
        let tam = size.width > size.height ? size.height : size.width;
        UIGraphicsBeginImageContext(CGSize(width: tam, height: tam));
        self.drawInRect(CGRect(x: (tam-size.width)*0.5, y: (tam-size.height)*0.5, width: size.width, height: size.height));
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    
}

extension String{
    
    func stringByAppendingPathComponent(string : String) -> String{
        return self + "/" + string;
    }
    
}
