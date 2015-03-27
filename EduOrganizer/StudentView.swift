//
//  StudentView.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/23/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class StudentView : UIView {
    
    var horTableProfessor : HorizontalTableView!;
    var horTableSubjects : HorizontalTableView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        parent.title = "Student";
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!,NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        parent.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        var sectionTeacher : UILabel = UILabel(frame: CGRectMake(0,0, frame.width, frame.height/12));
        sectionTeacher.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        var labelTeacher : UILabel = UILabel(frame: CGRectMake(sectionTeacher.frame.origin.x + 20,
                                                               sectionTeacher.frame.origin.y,
                                                               frame.width,
                                                               sectionTeacher.frame.height));
        
        labelTeacher.font = UIFont(name: "AvenirNext-Bold", size: 15);
        labelTeacher.textAlignment = NSTextAlignment.Left;
        labelTeacher.textColor = UIColor.whiteColor();
        labelTeacher.text = "Teachers";
        
        horTableProfessor = HorizontalTableView(frame: CGRectMake(0,
                                                                  sectionTeacher.frame.origin.y + sectionTeacher.frame.height ,
                                                                  frame.width,
                                                                  frame.height/4.5),
                                                delegate : parent as StudentVC,
                                                color: UIColor.UIColorFromRGB(0x1e3044));
        
        var sectionSubjects : UILabel = UILabel(frame: CGRectMake(0,
                                                                  horTableProfessor.frame.origin.y + horTableProfessor.frame.height,
                                                                  frame.width,
                                                                  sectionTeacher.frame.height));
        
        sectionSubjects.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
    
        var labelSubjects : UILabel = UILabel(frame: CGRectMake(sectionSubjects.frame.origin.x + 20,
                                                                sectionSubjects.frame.origin.y,
                                                                frame.width,
                                                                sectionTeacher.frame.height));
        
        labelSubjects.font = UIFont(name: "AvenirNext-Bold", size: 15);
        labelSubjects.textAlignment = NSTextAlignment.Left;
        labelSubjects.textColor = UIColor.whiteColor();
        labelSubjects.text = "Subjects";
        
        horTableSubjects = HorizontalTableView(frame: CGRectMake(0,
                                                                 sectionSubjects.frame.origin.y +
                                                                    sectionSubjects.frame.height ,
                                                                 frame.width,
                                                                 frame.height/4.5),
                                                                 delegate : parent as StudentVC,
                                                                 color: UIColor.UIColorFromRGB(0x1e3044));
        
        view.addSubview(sectionTeacher);
        view.addSubview(labelTeacher);
        view.addSubview(horTableProfessor);
        view.addSubview(sectionSubjects);
        view.addSubview(labelSubjects);
        view.addSubview(horTableSubjects);
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}