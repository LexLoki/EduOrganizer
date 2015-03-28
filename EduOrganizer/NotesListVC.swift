//
//  NotesListVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 3/24/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController, UITableViewDataSource {
    var tableView: UITableView!
    
    var notes : Array<NoteModel> = Array<NoteModel>();
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //data source da table view
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);

        //registrando o identificador da célula
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        //n tem colchete pq eh so um nome
        title = "Notes"; 

    }
    
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //quantidade de celulas para uma seçao
        return self.notes.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //conteudo de celulas para uma secao
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell;
       
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = false;
        cell.textLabel?.text = notes[indexPath.row].nome;
        
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20);
        cell.textLabel?.textAlignment = NSTextAlignment.Left;
        
        if (notes[indexPath.row].imagens?.count > 0){
            cell.imageView?.image = UIImage(named: "attachment");
        }

        
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044)
        } else {
            cell.backgroundColor = UIColor.UIColorFromRGB(0x294b70)
        }
        
        return cell
    }

}
