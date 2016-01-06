//
//  NotesListVC.swift
//  Stud
//
//  Created by Juliana Zilberberg on 3/24/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import UIKit

class NotesListVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    //Declaracao da tableView
    var notesListView: NotesListView!

    var selectedIndex: Int = Int();
    
    var notes : Array<NoteModel> = Array<NoteModel>();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes";
        
        notesListView = NotesListView(view: view, parent: self);
        notesListView.tableView.delegate = self;
        notesListView.tableView.dataSource = self;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let noteDAO = NoteDAO()
        notes = noteDAO.getDataArray() as! Array<NoteModel>;
        notesListView.tableView.reloadData();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //quantidade de celulas para uma seçao
        return notes.count
    }
    
    //Altura de cada cell (15% da altura da tela)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return view.frame.height*0.12;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //conteudo de celulas para uma secao
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
       
        cell.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.UIColorFromRGB(0x294b70);
        cell.preservesSuperviewLayoutMargins = false;
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20);
        cell.textLabel?.textAlignment = NSTextAlignment.Left;
        cell.textLabel?.text = notes[indexPath.row].nome;
        
        //Aqui botamos imagem do clipe caso tenha fotos
        if (notes[indexPath.row].imagens?.count > 0){
            cell.imageView?.image = UIImage(named: "attachment");
        }
        
        //Aqui para setar a cor da cell
        if(indexPath.row%2 == 0){
            cell.backgroundColor = UIColor.UIColorFromRGB(0x1e3044)
        } else {
            cell.backgroundColor = UIColor.UIColorFromRGB(0x294b70)
        }
        
        return cell
    }
    
    //Essa funcao é chamada quando clicamos em uma nota especifica (aqui que vamos abri-la)
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row;
        performSegueWithIdentifier("infoNote", sender: nil);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as? AddNotesVC;
        destinationVC?.note = notes[selectedIndex];
    }
    
    @IBAction func unwindToContainerVC(segue:UIStoryboardSegue) {
    
    }
}
