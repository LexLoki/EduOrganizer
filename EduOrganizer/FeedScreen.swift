//
//  FeedScreen.swift
//  EduOrganizer
//
//  Created by Pietro Ribeiro Pepe on 3/11/15.
//  Copyright (c) 2015 Pietro Ribeiro Pepe. All rights reserved.
//

import Foundation
import UIKit

class FeedScreen:UITableViewController,UITableViewDataSource{
    
    var professores:NSMutableArray=NSMutableArray();
    //var table:UITableView=UITableView();
    var cell:UITableViewCell=UITableViewCell();
    var imagens:NSArray=NSArray();
    var nomes:NSArray=NSArray();
    var detalhes:NSArray=NSArray();
    
    override func viewDidLoad() {
        //cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HOHOHO");
        println("carregado");
        setupInterface();
        //self.tableView.delegate=self;
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HOHOHO");
    }
    
    func setupInterface(){
        nomes=["andrew","hendi","john","ugulino"];
        detalhes=["D.Sc. pela PUC-Rio, pesquisador em qualidade de software. Também conhecido como 'brown chocolate babe'.",
        "Comunicador pela UNISINOS, experiente desenvolvedor iOS. Também conhecido como 'Pai Hendi'ou 'moço dos olhos verdes'.",
        "Comunicador pela HHHHHHH, especialista em gerencia de projetos. Também conhecido como 'Joe Montanha'",
        "D.Sc. pela PUC-Rio, pesquisador em wearable computing. Também conhecido como o professor mais legal do BEPiD@Rio"];
        //var img:UIImage = UIImage(named: "andrew")!
        imagens=[UIImage(named:"andrew")!,
        UIImage(named:"hendi")!,
        UIImage(named:"john")!,
        UIImage(named:"ugulino")!];
        loadProfessores();
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professores.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("hueAmigu");
        //var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("HOHOHO", forIndexPath: indexPath) as UITableViewCell;
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "HOHOHO");
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel?.text = (professores[indexPath.row]["nome"] as String);
        cell.detailTextLabel?.text = (professores[indexPath.row]["e-mail"] as String);
        cell.imageView?.image = (professores[indexPath.row]["imagem"] as UIImage);
        cell.detailTextLabel?.numberOfLines=6;
        cell.detailTextLabel?.lineBreakMode=NSLineBreakMode.ByWordWrapping;
        return cell;
    }
    
    func loadProfessores(){
        var documentPath:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;
        var plistPath:String = documentPath.stringByAppendingPathComponent("userData.plist");
        let contents:NSDictionary = NSDictionary(contentsOfFile: plistPath)!;
        var allProf:NSMutableDictionary = contents["professores"] as NSMutableDictionary;
        println(plistPath);
        var imgPath:String = documentPath.stringByAppendingPathComponent("imgProf");
        for (id,var prof) in allProf{
            //prof = (prof as NSMutableDictionary)
            var mutProf:NSMutableDictionary = prof.mutableCopy() as NSMutableDictionary;
            mutProf.setObject(id, forKey: "id");
            var profImg:String = imgPath.stringByAppendingPathComponent(prof["imagem"] as String);
            mutProf.setObject(UIImage(contentsOfFile:profImg)!, forKey: "imagem");
            println(profImg);
            //var img:UIImage=UIImage(contentsOfFile: profImg)!;
            self.professores.addObject(mutProf);
        }
    }
    
//    -(NSMutableArray*)loadStatus:(int)map{
//
//    /* att para documents
//    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"StagesData" ofType:@"plist"];
//    contentArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
//    */
//    // <por>
//    NSString *plistPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    plistPath = [plistPath stringByAppendingPathComponent:@"StagesData.plist"];
//    contentArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
//    //</por>
//    
//    NSMutableArray *mapData = [contentArray objectAtIndex:map];
//    NSMutableArray *stat = [[NSMutableArray alloc]initWithCapacity:[mapData count]];
//    stagesName = [[NSMutableArray alloc]initWithCapacity:[mapData count]];
//    
//    requisites = [[NSMutableArray alloc]initWithCapacity:[mapData count]];
//    for (NSDictionary *stage in mapData){
//    [requisites addObject:[stage objectForKey:@"requisites"]];
//    [stat addObject:[stage objectForKey:@"status"]];
//    [stagesName addObject:[stage objectForKey:@"name"]];
//    }
//    //CHECK FOR PRE-ATT
//    NSInteger cont=[stat count], aux, flag=0, flag2=0;
//    stagesToOpen = [[NSMutableArray alloc]initWithCapacity:cont-1];
//    if(stageToChange!=-1){
//    
//    for(int i=0;i<cont;i++){
//    if([[stat objectAtIndex:i] intValue]==0){
//    aux=0;
//    for(NSNumber *req in [requisites objectAtIndex:i]){
//    NSLog(@"Looking req of %d -> %d", i, [req intValue]);
//    if([[stat objectAtIndex:[req intValue]]intValue]!=2)
//    aux++;
//    }
//    if(aux==0){
//    NSLog(@"Found u mutherfucker %d", i);
//    [stat replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:1]];
//    [[mapData objectAtIndex:i] setObject:[NSNumber numberWithInt:1] forKey:@"status"];
//    [stagesToOpen addObject:[NSNumber numberWithInt:i]];
//    flag++;
//    }
//    }
//    if([[stat objectAtIndex:i] intValue]==1){
//    flag2++;
//    }
//    }
//    if(flag!=0)
//    [contentArray writeToFile:plistPath atomically:true];
//    else if(flag2==0){
//    NSLog(@"openMap");
//    [self openMap:mapIndex];
//    }
//    }
//    //--
//    return stat;
//    }
    
}