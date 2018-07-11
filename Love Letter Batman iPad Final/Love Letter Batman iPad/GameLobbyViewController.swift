//
//  CardDataViewController.swift
//  FinalProjectCS385
//
//  Created by T5A User on 11/20/16.
//  Copyright © 2016 USAFA. All rights reserved.
//

import UIKit

class GameLobbyViewController: UIViewController {
    
    var nameList : [String] = []
    
    override func viewDidLoad() {
        checkFields()
    }
    
    @IBAction func addPlayer(sender: AnyObject) {
        var num = Int(numPlayers.text!)!
        if(num < 4){
            num = num + 1
            numPlayers.text = String(num)
        }
        checkFields()
    }
    
    @IBAction func subtractPlayer(sender: AnyObject) {
        var num = Int(numPlayers.text!)!
        if(num > 2){
            num = num - 1
            numPlayers.text = String(num)
        }
        checkFields()
    }
    
    func checkFields(){
        let num = Int(numPlayers.text!)!
        
        if(num == 2){
            p3Label.hidden = true
            p4Label.hidden = true
            p3Name.hidden = true
            p4Name.hidden = true
        } else if(num == 3){
            p3Label.hidden = false
            p4Label.hidden = true
            p3Name.hidden = false
            p4Name.hidden = true
        } else if(num == 4){
            p3Label.hidden = false
            p4Label.hidden = false
            p3Name.hidden = false
            p4Name.hidden = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let num = Int(numPlayers.text!)!
        
        nameList.append(p1Name.text!)
        nameList.append(p2Name.text!)
        if(num == 3){
            nameList.append(p3Name.text!)
        }
        if(num == 4){
            nameList.append(p3Name.text!)
            nameList.append(p4Name.text!)
        }
        
        (segue.destinationViewController as! GameViewController).delegate = self
    }
    
    @IBOutlet weak var p1Name: UITextField!
    @IBOutlet weak var p2Name: UITextField!
    @IBOutlet weak var p3Name: UITextField!
    @IBOutlet weak var p4Name: UITextField!
    
    @IBOutlet weak var p3Label: UILabel!
    @IBOutlet weak var p4Label: UILabel!
    
    @IBOutlet weak var numPlayers: UILabel!
    
    
}
