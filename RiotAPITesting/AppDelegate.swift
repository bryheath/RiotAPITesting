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
       league.lolAPI.getAllChampionIds() { (championsIDs, errorMsg) in
            if championsIDs != nil {
                for i in 0..<championsIDs!.count {
                    league.lolAPI.getChampionDetails(by: championsIDs![i]) { (champ, errorMsg) in
                        if let champ = champ {
                            championNamesDictionary.updateValue(champ.name, forKey: champ.championId.value)
                            
                        }
                        
                    }
                }
            }
           
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

