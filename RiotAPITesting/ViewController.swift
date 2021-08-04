//
//  ViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/9/21.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var matchList: MatchList?
    var summoner: Summoner?
    var region: Region?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerNameTextField.text = "SunraiRW"
    }
    
    @IBOutlet var playerNameTextField: UITextField!
    @IBAction func lookupButtonPressed(_ sender: UIButton) {
        if playerNameTextField.text != nil && playerNameTextField.text != "" {
            preferredSummoner = playerNameTextField.text!
            self.performSegue(withIdentifier: "lookupSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("top of Prepare")
        
    }
    
   
    

    
   
}

