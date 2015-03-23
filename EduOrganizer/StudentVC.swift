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
    var studentView : StudentView!;
    var selectedIndex:Int = Int();
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        
        studentView = StudentView(frame: view.frame, parent: self);
        studentView.horTableProfessor.delegate = self;
        view = studentView;
        
        var professorDAO = ProfessorDAO();
        professores = professorDAO.getDataArray() as Array<ProfessorModel>;

        
    }
    
    func tableView(horizontalTableView: HorizontalTableView, didSelectRowAtIndexPath: NSIndexPath){
        //nada
    }
    func tableView(horizontalTableView: HorizontalTableView, numberOfRows: Int) -> Int {
        return professores.count;
    }
    
    func numberOfSectionsInTableView(horizontalTableView: HorizontalTableView) -> Int {
        return 1;
    }
    
    func tableView(horizontalTableView: HorizontalTableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        
        var professorCell : StudentCell = StudentCell(view: view);
        
        if (horizontalTableView == studentView.horTableProfessor){
            
            var professor : ProfessorModel = professores[cellForRowAtIndexPath.row] as ProfessorModel;

            professorCell.btnCell.tag = cellForRowAtIndexPath.row;
            professorCell.btnCell.addTarget(self,
                                            action: "teacherTouched:",
                                            forControlEvents: UIControlEvents.TouchUpInside);
            
            
            if let image = professor.imagem {
                
                professorCell.label.font = UIFont(name: "AvenirNext-Bold", size: 40)
                professorCell.btnCell.setImage(professor.imagem, forState: UIControlState.Normal);
                
            }else{
                
                var nomeArray = professor.nome.componentsSeparatedByString(" ");
                var nome : String = "";
                
                if (nomeArray.count > 0){
                    var primeiroNome = nomeArray[0];
                    var primeiraLetra = primeiroNome.substringToIndex(advance(primeiroNome.startIndex, 1));
                    
                    var nome = primeiraLetra;
                    
                    if (nomeArray.count > 1){
                        var ultimoNome = nomeArray[nomeArray.count - 1];
                        var ultimaLetra = ultimoNome.substringToIndex(advance(ultimoNome.startIndex, 1));
                        
                        nome = nome + ultimaLetra;
                    }
                    
                    professorCell.label.text = nome;
                }
            }
            
            return professorCell;
            
        }else{
            
            //carregar materias
            
        }
        
        return professorCell;
    }
    
    func teacherTouched(sender:UIButton){
        selectedIndex = sender.tag;
        performSegueWithIdentifier("infoProfessor", sender: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? ProfessorInfoVC;
        destinationVC?.professor = professores[selectedIndex];
    }
    
    func tableView(horizontalTableView: HorizontalTableView, widthForCellAtIndexPath: NSIndexPath) -> CGFloat {
        return view.frame.width/2.5;
    }
}