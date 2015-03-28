//
//  AppDelegate.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/11/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent;
        window?.tintColor =  UIColor.UIColorFromRGB(0xFFC561);

        checkFiles("userData", type: ".plist");
        
        return true
    }
    
    func checkFiles(filename:String, type:String){
        
        var destPath:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        var imgPath:String = destPath;
        destPath = destPath.stringByAppendingPathComponent("\(filename)\(type)");
        
        println(destPath);
        
        // If the file doesn't exist in the Documents Folder, copy it.
        var fileManager:NSFileManager = NSFileManager.defaultManager();
        if(!fileManager.fileExistsAtPath(destPath)){
            let sourcePath:String = NSBundle.mainBundle().pathForResource(filename, ofType: type)!;
            fileManager.copyItemAtPath(sourcePath, toPath: destPath, error: nil);
        }
        
        var imgProfPath = imgPath.stringByAppendingPathComponent("imgProf");
      
        fileManager.createDirectoryAtPath(imgProfPath, withIntermediateDirectories:false, attributes:nil, error:nil);
        
        var filename:String = "christine";
        var img:UIImage = UIImage(named: filename)!;
        var pngData:NSData = UIImagePNGRepresentation(img);
        var imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
      
        filename = "hugofuks";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
        
        filename = "spesco";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        imgProfPath2 = imgProfPath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgProfPath2, contents: pngData, attributes:nil);
        
        /*
        ///
        */
        
        var imgNotePath = imgPath.stringByAppendingPathComponent("imgNote");
      
        fileManager.createDirectoryAtPath(imgNotePath, withIntermediateDirectories:false, attributes:nil, error:nil);
        
        filename = "note";
        img = UIImage(named: filename)!;
        pngData = UIImagePNGRepresentation(img);
        var imgNotePath2 = imgNotePath.stringByAppendingPathComponent("\(filename).png");
        fileManager.createFileAtPath(imgNotePath2, contents: pngData, attributes:nil);

        
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

