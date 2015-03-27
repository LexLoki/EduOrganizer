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
    //var notes : Array<UILabel>; ADICIONAR DEPOIS
    
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
        
        parent.title = "Student";
        
        var sectionTeacher : UILabel = UILabel(frame: CGRectMake(0,0, frame.width, frame.height/18)); //12
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
        
        
        
        var sectionNotes : UILabel = UILabel(frame: CGRectMake(0,
            horTableSubjects.frame.origin.y + horTableSubjects.frame.height,
            frame.width,
            sectionTeacher.frame.height));
            sectionNotes.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        var labelNotes : UILabel = UILabel(frame: CGRectMake(sectionNotes.frame.origin.x + 20,
            sectionNotes.frame.origin.y,
            frame.width,
            sectionTeacher.frame.height));
        
        
        labelNotes.font = UIFont(name: "AvenirNext-Bold", size: 15);
        labelNotes.textAlignment = NSTextAlignment.Left;
        labelNotes.textColor = UIColor.whiteColor();
        labelNotes.text = "Notes";

        view.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        view.addSubview(sectionTeacher);
        view.addSubview(labelTeacher);
        view.addSubview(horTableProfessor);
        view.addSubview(sectionSubjects);
        view.addSubview(labelSubjects);
        view.addSubview(horTableSubjects);
        view.addSubview(sectionNotes);
        view.addSubview(labelNotes);

        
//        var i:Int;
//        for(i=0;i<3;i++){
//            notes.append(noteBox());
//        }
        
    }
    
//    func noteBox(frame:CGRect){
//        var offSet : CGFloat = 0.1 * view.frame.size.width;
//        var caixa : CGRect = CGRectMake(offSet,
//            0,
//            view.frame.size.width-offSet,
//            view.frame.size.height/18.0);
//        
//        var label:UILabel = UILabel(frame: CGRectMake(20, 20, view.frame.width, 20));
//        label.textColor = UIColor.whiteColor();
//        label.textAlignment = NSTextAlignment.Left;
//    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}