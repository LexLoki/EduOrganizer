//
//  Professor.swift
//  EduOrganizer
//
//  Created by Haroldo Olivieri on 3/20/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation

class ProfessorModel{
    
    var id : Int!;
    var nome : String!;
    var email : String!;
    var telefone : String!;
    var imagem : String!;
    var materias : Array<SubjectModel>!;
    
    init(){
    }
}
