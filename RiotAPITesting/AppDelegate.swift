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

    var summoner: Summoner?
    var matchList: MatchList?
    var region: Region?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        checkCacheVersion(championName: "Diana")
        createChampionsDictionary()
        
//        printStatisticRankings(statistic: .AS)
//        printStatisticRankings(statistic: "attackdamage")
//        getMultiplifedCompoundValue(first: "attackspeed", second: "attackdamage")
//        getAdditionedCompoundValue(first: .Armor, second: .MagicResist)
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
         //printChampDetails(champ: allChampions[50])
//        if let champ = getChampionDetailsByID(championID: ChampionId(266)) {
//            printChampDetails(champ: champ)
//            print("===============================")
//
//        }
//        if let champ = getChampionDetailsByID(championID: ChampionId(131)) {
//            printChampDetails(champ: champ)
//            print("===============================")
//
//        }
//        if let champ = getChampionDetailsByID(championID: ChampionId(25)) {
//            printChampDetails(champ: champ)
//            print("===============================")
//
//        }
        

       
        
        
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

