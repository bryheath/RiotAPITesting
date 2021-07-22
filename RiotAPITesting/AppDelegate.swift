//
//  AppDelegate.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/9/21.
//

import UIKit
import LeagueAPI
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
//    let league = LeagueAPI(APIToken: "RGAPI-70c99cc7-efbf-402d-adfe-35d54578ed6c") //issued 7-17-21 255pm
//    var accountID:AccountId = AccountId("U3JswvnYvMkTywOokmYUpAi0i0dLlW-LKY8m6yaKj0dWtPw")
    //var accountID:AccountId = AccountId("U3JswvnYvMkTywOokmYUpAi0i0dLlW-LKY8m6yaKj0dWtPw")
    var summoner: Summoner?
    var matchList: MatchList?
    var region: Region?
//    var championsDetailArray = [ChampionDetails]()
   
    

//    let league = LeagueAPI(APIToken: "RGAPI-20b1ad21-3c0e-46c0-91d1-889aaee01953")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//       league.lolAPI.getAllChampionIds() { (championsIDs, errorMsg) in
//            if championsIDs != nil {
//                for i in 0..<championsIDs!.count {
//                    league.lolAPI.getChampionDetails(by: championsIDs![i]) { (champ, errorMsg) in
//                        if let champ = champ {
//                            championNamesDictionary.updateValue(champ.name, forKey: champ.championId.value)
//                            print(championNamesDictionary)
//                        }
//                        
//                    }
//                }
//                
//                //getChampionDetailsByID(championID: champid)
//            }
//           
//        }
        if let champ = getChampionDetailsByID(championID: ChampionId(266)) {
            printChampDetails(champ: champ)
            print("===============================")
            
        }
        if let champ = getChampionDetailsByID(championID: ChampionId(131)) {
            printChampDetails(champ: champ)
            print("===============================")
            
        }
        if let champ = getChampionDetailsByID(championID: ChampionId(25)) {
            printChampDetails(champ: champ)
            print("===============================")
            
        }
        var armorRankings = Dictionary<String, Double>()
        for (key, value) in championNamesDictionary {
            if let champ = getChampionDetailsByID(championID: ChampionId(key)) {
                let armor = champ.stats["armor"]
                let armorGrowth = champ.stats["armorperlevel"]
                let level18Armor = armor!+17*armorGrowth!
                armorRankings[value] = level18Armor
                
            }
        }
        let newArmorRankings = armorRankings.sorted(by:{
            (first: (String, Double), second: (String, Double)) -> Bool in
            first.1 > second.1
        })
        
        print(newArmorRankings)
        
        var mrRankings = [String:Double]()
        for (key, value) in championNamesDictionary {
            if let champ = getChampionDetailsByID(championID: ChampionId(key)) {
                let mr = champ.stats["spellblock"]
                let mrGrowth = champ.stats["spellblockperlevel"]
                let level18MR = mr!+17*mrGrowth!
                mrRankings[value] = level18MR
                
            }
        }
        let newMRRankings = mrRankings.sorted(by:{
            (first: (String, Double), second: (String, Double)) -> Bool in
            first.1 > second.1
        })
        
        print(newMRRankings)
        var tankyRankings = [String: Double]()
        
        for (champToTest, value) in newArmorRankings {
            
            let mrValue = mrRankings["\(champToTest)"]
            let totalValue = value+mrValue!
            tankyRankings[champToTest] = totalValue
            
        }
        let newTankyRankings = tankyRankings.sorted(by: {
            (first: (String, Double), second: (String, Double)) -> Bool in
            first.1 > second.1
        })
        //print(newTankyRankings)
        
        for (tankyChamp, value) in newTankyRankings {
            print("\(tankyChamp): \(value)")
        }
        league.lolAPI.getSummonerSpells() { (spells, errorMsg) in
            if let spells = spells {
                for spell in 0..<spells.count {
                    let name = spells[spell].name
                    let id = spells[spell].id.value
                    summonerSpellDictionary.updateValue(name, forKey: id)
                }
            }
           
        }
       
        
        
        return true
    }

    func printChampDetails(champ: Datum) {
        print("Name: \(champ.name)")
        print("Title: \(champ.title)")
        let stats = champ.stats
        let hp: Double = stats["hp"]!
        print("HP: \(hp)")
        let hpLevel18 = hp + 17*stats["hpperlevel"]!
        print("HP @ Level 18: \(hpLevel18)")
        print("Mana: \(stats["mp"]!)")
    
        print("Mana @ Level 18: \(stats["mp"]!+17*stats["mpperlevel"]!)")
        print("Speed: \(stats["movespeed"]!)")
        print("Armor: \(stats["armor"]!)")
        print("Armor @ Level 18: \(stats["armor"]!+17*stats["armorperlevel"]!)")
        print("MR: \(stats["spellblock"]!)")
        print("MR @ Level 18: \(stats["spellblock"]!+17*stats["spellblockperlevel"]!)")
        print("Attack Range: \(stats["attackrange"]!)")
        print("AD: \(stats["attackdamage"]!)")
        print("AD @ Level 18: \(stats["attackdamage"]!+17*stats["attackdamageperlevel"]!)")
        print("AS: \(stats["attackspeed"]!)")
        print("AS @ Level 18: \(stats["attackspeed"]!*(1+(17*stats["attackspeedperlevel"]!/100)))")
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

