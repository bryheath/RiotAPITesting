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
        
        
    }
    
    @IBOutlet var playerNameTextField: UITextField!
    @IBAction func lookupButtonPressed(_ sender: UIButton) {
        if playerNameTextField.text != nil && playerNameTextField.text != "" {
            preferredSummoner = playerNameTextField.text!
//                    gameListTableViewController.yourPlayer = playerNameTextField.text!
            print("Inside nameField stuff")
            self.performSegue(withIdentifier: "lookupSegue", sender: nil)
//            getSummoner(summoner: preferedSummoner, region: preferedRegion)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("top of Prepare")
        
    }
    
   
    
//    func getSummoner(summoner: String, region: Region) {
//        league.lolAPI.getSummoner(byName: summoner, on: region) { (name, errorMsg) in
////            let group = DispatchGroup()
//
//            if let name = name {
////                group.enter()
//                print("Inside getSummoner")
//
//                self.getMatches(summoner: name.name, region: region)
////                group.leave()
////                group.notify(queue: .main) {
//
////                }
//
//            }
//        }
//
//    }
    
//    func getMatches(summoner: String, region: Region) {
//        league.lolAPI.getSummoner(byName: summoner, on: region) { (name, errorMsg) in
//            if let name = name {
//                self.getMatchList(accountID: name.accountId, region: region)
//            }
//        }
//    }
    
   
}

