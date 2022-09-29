////
////  Champion.swift
////  RiotAPITesting
////
////  Created by Bryan Work on 7/21/21.
////
//
//import Foundation
//import LeagueAPI
//
//public var allChampions:Array = [Datum]()
//
//public func printChampDetails(champ: Datum) {
//    print("Name: \(champ.name)")
//    print("Title: \(champ.title)")
//    let stats = champ.stats
//    let hp: Double = stats["hp"]!
//    print("HP: \(hp)")
//    let hpLevel18 = hp + 17*stats["hpperlevel"]!
//    print("HP @ Level 18: \(hpLevel18)")
//    print("Mana: \(stats["mp"]!)")
//
//    print("Mana @ Level 18: \(stats["mp"]!+17*stats["mpperlevel"]!)")
//    print("Speed: \(stats["movespeed"]!)")
//    print("Armor: \(stats["armor"]!)")
//    print("Armor @ Level 18: \(stats["armor"]!+17*stats["armorperlevel"]!)")
//    print("MR: \(stats["spellblock"]!)")
//    print("MR @ Level 18: \(stats["spellblock"]!+17*stats["spellblockperlevel"]!)")
//    print("Attack Range: \(stats["attackrange"]!)")
//    print("AD: \(stats["attackdamage"]!)")
//    print("AD @ Level 18: \(stats["attackdamage"]!+17*stats["attackdamageperlevel"]!)")
//    print("AS: \(stats["attackspeed"]!)")
//    print("AS @ Level 18: \(stats["attackspeed"]!*(1+(17*stats["attackspeedperlevel"]!/100)))")
//}
//
//public func createChampionsArray() {
//    for champion in championNamesDictionary {
//        if let champ = getChampionDetailsByID(championID: ChampionId(champion.key)) {
//            allChampions.append(champ)
//        }
//    }
//    allChampions = allChampions.sorted(by: {
//        (first: Datum, second: Datum) -> Bool in
//        Int(first.key)! < Int(second.key)!
//
//    })
//}
//
//
