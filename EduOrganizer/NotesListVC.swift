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
    var tableView: UITableView!

    var selectedIndex: Int = Int();
    
    var notes : Array<NoteModel> = Array<NoteModel>();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //n tem colchete pq eh so um nome
        title = "Notes";
        
        //inicializacao da tableView
        tableView = UITableView(frame: CGRectMake(0,0,view.frame.width,view.frame.height))
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.UIColorFromRGB(0x1a242e);
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1a242e);
        view.addSubview(tableView);
        
        //delegate e data source da table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsZero;
        tableView.backgroundColor = UIColor.UIColorFromRGB(0x1e3044);
        

        //registrando o identificador da célula
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData();
        var noteDAO = NoteDAO()
        notes = noteDAO.getDataArray() as Array<NoteModel>;
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell;
       
        cell.layoutMargins = UIEdgeInsetsZero;
        tableView.separatorColor = UIColor.UIColorFromRGB(0x1e3044);
        cell.preservesSuperviewLayoutMargins = false;
        cell.textLabel?.text = notes[indexPath.row].nome;
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 20);
        cell.textLabel?.textAlignment = NSTextAlignment.Left;
        
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
        destinationVC?.textToLoad = notes[selectedIndex].texto;
        destinationVC?.segueDone = "noteInfo";
        destinationVC?.title = notes[selectedIndex].nome;
        destinationVC?.note = notes[selectedIndex];
    }
}
