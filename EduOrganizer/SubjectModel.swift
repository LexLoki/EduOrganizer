//
//  SubjectsModel.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class SubjectModel{
    
    var id : String!;
    var notes : Array<AnyObject>!;
    var professor : ProfessorModel!;
    var nome : String!;
    var tarefas : Array<AnyObject>!;
    
    init(){
    }
}