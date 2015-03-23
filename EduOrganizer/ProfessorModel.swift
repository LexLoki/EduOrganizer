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
    var imagem : UIImage?;
    var materias : Array<AnyObject>!;
    
    init(){
        
        nome = "não informado";
        email = "não informado";
        telefone = "não informado";

    }
}
