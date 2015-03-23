//
//  SchoolScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/13/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class StudentVC: UIViewController, TableViewDelegate{

    var professores : Array<ProfessorModel> = Array<ProfessorModel>();
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as Array<ProfessorModel>;
        
        view.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        
        let attributes = [NSFontAttributeName:UIFont(name: "Avenir Next", size: 20)!, NSForegroundColorAttributeName: UIColor.UIColorFromRGB(0xFFFFFF)];
        self.navigationController?.navigationBar.titleTextAttributes = attributes;
        
        self.title = "Student";
    
        //create label section teacher
        var labelSectionTeacher : UILabel = UILabel(frame: CGRectMake(0,0, view.frame.width, 50));
        labelSectionTeacher.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        
        var labelSectionTeacherText : UILabel = UILabel(frame: CGRectMake(20,0, view.frame.width, 50));
        labelSectionTeacherText.font = UIFont(name: "AvenirNext-Bold", size: 15);
        labelSectionTeacherText.textAlignment = NSTextAlignment.Left;
        labelSectionTeacherText.textColor = UIColor.whiteColor();
        labelSectionTeacherText.text = "Teachers";
        
        var horizontalTeachersView : HorizontalTableView = HorizontalTableView(frame: CGRectMake(0, 50, view.frame.width, 120), delegate : self, color: UIColor.UIColorFromRGB(0x1e3044));
        
        var thirdIndex = NSIndexPath(forRow: professores.count/3, inSection: 0);
        horizontalTeachersView.tableView.scrollToRowAtIndexPath(thirdIndex, atScrollPosition: UITableViewScrollPosition.Bottom, animated: false);

        view.addSubview(horizontalTeachersView);
        view.addSubview(labelSectionTeacher);
        view.addSubview(labelSectionTeacherText);
        
    }
    
    func tableView(horizontalTableView: HorizontalTableView, didSelectRowAtIndexPath: NSIndexPath) {
    }
    
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return professores.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = UITableViewCell(frame: CGRectMake(0, 0, 150, 150));
        //var imageView : UIImageView = UIImageView(frame: CGRectMake(20, 10, 100, 100));
        
        var professor : ProfessorModel = professores[cellForRowAtIndexPath.row] as ProfessorModel;
     
        var btnTeacher   = UIButton.buttonWithType(UIButtonType.Custom) as UIButton;
        btnTeacher.frame = CGRectMake(20, 10, 100, 100);
        btnTeacher.setImage(professor.imagem, forState: UIControlState.Normal);
        btnTeacher.tag = cellForRowAtIndexPath.row;
        btnTeacher.addTarget(self, action: "teacherTouched:", forControlEvents: UIControlEvents.TouchUpInside);
        
        btnTeacher.layer.cornerRadius = btnTeacher.frame.size.height/2;
        btnTeacher.layer.masksToBounds = true;
        btnTeacher.contentMode = UIViewContentMode.ScaleAspectFit;
        btnTeacher.layer.borderWidth = 0;
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        cell.addSubview(btnTeacher);
        
        return cell;
    }
    
    func teacherTouched(sender:UIButton){
        performSegueWithIdentifier("subjects", sender: nil);2
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return 130;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForHeaderInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, viewForFooterInSection: Int) -> UIView {
        var m : UIView = UIView(frame: CGRectMake(0, 0, 50,90));
        return m;
    }
}