//
//  NotesListVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 3/24/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var notes : Array<NoteModel> = Array<NoteModel>();
    //var notes:[String] = ["Gordon Empathy tips", "Gordon Empathy tips"] //declarando seu array(titulos das notas)//
    //var noteDAO = NoteDAO();
    //var notes:Array = noteDAO.getDataArray();
    //var notes:Array = [];
    
    override func viewDidLoad() {
        super.viewDidLoad() //data source da table view//
        self.tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsetsZero;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")//registrando o datasource//
        self.navigationController?.title = "Notes" //n tem colchete pq eh so um nome//
        println("viewDidLoad")
    }
    
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //quantidade de celulas para uma seçao//
        return self.notes.count //quantidade de celular do array preenchido//
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //conteudo de celulas para uma secao//
        let cell=tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell//poder reusar a celulas caso exista ja//
        cell.textLabel.text = self.notes[indexPath.row].nome//chamando as anotacoes e relacionando com a posicao exata do array que foi preenchida//
        cell.textLabel.textColor = UIColor.whiteColor();
        cell.textLabel.font = UIFont(name: "Avenir Next", size: 34)
        cell.textLabel.textAlignment = NSTextAlignment.Left;
        
        
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044)
        } else {
            cell.backgroundColor = UIColor.UIColorFromRGB(0x2b4c6f)
        }
        
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
