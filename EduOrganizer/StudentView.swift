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
    var subjOptions : OptionsView!;
    var notesOptions : OptionsView!;
    var sectionSubjects : UIButton!;
    var sectionTeacher : UIButton!;
    var sectionNotes : UIButton!;
    var rightArrow : UIImageView!;
    var rightArrow2 : UIImageView!;
    var rightArrow3 : UIImageView!;
    
    init(view: UIView, parent: UIViewController) {
        super.init(frame: view.frame);
        
        frame = view.frame;
        view.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        
        parent.title = "Student";
        
        sectionSubjects = UIButton(frame: CGRectMake(0,0,frame.width,frame.height/18));
        sectionSubjects.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        var labelSubjects : UILabel = UILabel(frame: CGRectMake(sectionSubjects.frame.origin.x + 20,
                                                                sectionSubjects.frame.origin.y,
                                                                frame.width,
                                                                sectionSubjects.frame.height));

        
        labelSubjects = UILabel.setFontStyleBold(labelSubjects, sizeFont : 15);
        labelSubjects.text = "Subjects";
        
        var frameSubSection = CGRectMake(0,
                                      sectionSubjects.frame.origin.y +
                                        sectionSubjects.frame.height,
                                     frame.width,
                                     frame.height/4)
        
        subjOptions = OptionsView(frame : frameSubSection, rows : 3);
        
        let image = UIImage(named: "rightArrowStud") as UIImage?
        rightArrow = UIImageView (frame: CGRectMake(sectionSubjects.frame.width*0.91,
            sectionSubjects.frame.height*0.5 - 7.5, 15, 15))
        rightArrow.contentMode = UIViewContentMode.ScaleAspectFit
        rightArrow.image = image
        
        rightArrow2 = UIImageView (frame: CGRectMake(sectionSubjects.frame.width*0.91,
            sectionSubjects.frame.height*0.5 - 7.5, 15, 15))
        rightArrow2.contentMode = UIViewContentMode.ScaleAspectFit
        rightArrow2.image = image
        
        rightArrow3 = UIImageView (frame: CGRectMake(sectionSubjects.frame.width*0.91,
            sectionSubjects.frame.height*0.5 - 7.5, 15, 15))
        rightArrow3.contentMode = UIViewContentMode.ScaleAspectFit
        rightArrow3.image = image
        
        sectionSubjects.addSubview(rightArrow)
        
        
        sectionTeacher = UIButton(frame: CGRectMake(0,subjOptions.frame.origin.y + subjOptions.frame.height,
                                                   frame.width, frame.height/18));
        
        sectionTeacher.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        var labelTeacher : UILabel = UILabel(frame: CGRectMake(sectionTeacher.frame.origin.x + 20,
                                                               sectionTeacher.frame.origin.y,
                                                               frame.width,
                                                               sectionTeacher.frame.height));
        
        labelTeacher = UILabel.setFontStyleBold(labelTeacher, sizeFont : 15);
        labelTeacher.text = "Teachers";
        
        horTableProfessor = HorizontalTableView(frame: CGRectMake(0,
            sectionTeacher.frame.origin.y + sectionTeacher.frame.height ,
            frame.width,
            frame.height/4),
            delegate : parent as StudentVC,
            color: UIColor.UIColorFromRGB(0x1e3044));
        
        sectionTeacher.addSubview(rightArrow2)
        
        sectionNotes = UIButton(frame: CGRectMake(0,
                                                horTableProfessor.frame.origin.y +
                                                    horTableProfessor.frame.height,
                                                frame.width, frame.height/18));
        
            sectionNotes.backgroundColor = UIColor.UIColorFromRGB(0x1a242e)
        
        
        var labelNotes : UILabel = UILabel(frame: CGRectMake(sectionNotes.frame.origin.x + 20,
            sectionNotes.frame.origin.y,
            frame.width, frame.height/18));
        
        sectionNotes.addSubview(rightArrow3)
        
        
        labelNotes = UILabel.setFontStyleBold(labelNotes, sizeFont : 15);
        labelNotes.text = "Notes";
        
        var totalHeight = sectionSubjects.frame.height +
            subjOptions.frame.height +
            sectionTeacher.frame.height +
            horTableProfessor.frame.height +
            sectionNotes.frame.height +
            parent.navigationController!.navigationBar.frame.height +
            parent.tabBarController!.tabBar.frame.height +
            UIApplication.sharedApplication().statusBarFrame.size.height;
        
        var frameNoteSection = CGRectMake(0,
                                         sectionNotes.frame.origin.y +
                                         sectionNotes.frame.height,
                                         frame.width,
                                         frame.height - totalHeight)
        
        notesOptions = OptionsView(frame : frameNoteSection, rows : 2);
        
        sectionSubjects.tag = 0;
        sectionTeacher.tag = 1;
        sectionNotes.tag = 2;
        
        view.addSubview(sectionSubjects);
        view.addSubview(labelSubjects);
        view.addSubview(subjOptions);
        view.addSubview(sectionTeacher);
        view.addSubview(labelTeacher);
        view.addSubview(horTableProfessor);
        view.addSubview(sectionNotes);
        view.addSubview(labelNotes);
        view.addSubview(notesOptions);

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}