////
////  StatRankings.swift
////  RiotAPITesting
////
////  Created by Bryan Work on 7/29/21.
////
//
//import Foundation
//import LeagueAPI
//
//var armorRankings = [String: Double]()
//
//public enum Stats: String, CustomStringConvertible {
//    case HP = "hp"
//    case Mana = "mp"
//    case Speed = "movespeed"
//    case Armor = "armor"
//    case MagicResist = "spellblock"
//    case AttackRange = "attackrange"
//    case AD = "attackdamage"
//    case AS = "attackspeed"
//    case Crit = "crit"
//    
//    public var description: String {
//        return "\(self.rawValue)"
//    }
//}
//
//func getStatRankings(statistic: Stats) -> [String: Double] {
//    var statRankings = [String: Double]()
//    for (key, value) in championJSONNames {
//        if let champ = getChampionDetailsByID(championID: ChampionId(key)) {
//            let stat = champ.stats[statistic.rawValue]!
//            let perLevel = statistic.description + "perlevel"
//            if statistic.description == "attackspeed" {
//                let statGrowth = champ.stats[perLevel]! / 100
//                let level18Stat = stat * (1 + 17 * statGrowth)
//                statRankings[value] = level18Stat
//            } else {
//                let statGrowth = champ.stats[perLevel]!
//                let level18Stat = stat+17*statGrowth
//                statRankings[value] = level18Stat
//            }
//            
//            
//        } else {
//            print("Error with Key: \(key) - \(value)")
//        }
//    }
//    return statRankings
//}
//
//func getSortedStatRankingsArray(statistic: Stats) ->  [Dictionary<String,Double>.Element] {
//    let statsArray = getStatRankings(statistic: statistic)
//    let orderedStatRankings = statsArray.sorted(by:{
//        (first: (String, Double), second: (String, Double)) -> Bool in
//        first.1 > second.1
//    })
//    return orderedStatRankings
//}
//
//func printStatisticRankings(statistic: Stats) {
//    print("==============================")
//    print(statistic)
//    print("==============================")
//    let rankings = getSortedStatRankingsArray(statistic: statistic)
//    for (champ, value) in rankings {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumSignificantDigits = 3
//        let newValue = formatter.string(for: value)
//        print("\(champ): \(newValue!)")
//    }
//}
//
//func getMultiplifedCompoundValue(first: Stats, second: Stats) {
//    let firstStat = getStatRankings(statistic: first)
//    let secondStat = getStatRankings(statistic: second)
//    var compoundStat = [String: Double]()
//    for (champ, value) in firstStat {
//        compoundStat[champ] = Double(value * secondStat[champ]!)
//        
//    }
//    let orderedStatRankings = compoundStat.sorted(by:{
//        (first: (String, Double), second: (String, Double)) -> Bool in
//        first.1 > second.1
//    })
//    printCompoundValues(rankings: orderedStatRankings)
//}
//func getAdditionedCompoundValue(first: Stats, second: Stats) {
//    let firstStat = getStatRankings(statistic: first)
//    let secondStat = getStatRankings(statistic: second)
//    var compoundStat = [String: Double]()
//    for (champ, value) in firstStat {
//        compoundStat[champ] = Double(value + secondStat[champ]!)
//        
//    }
//    let orderedStatRankings = compoundStat.sorted(by:{
//        (first: (String, Double), second: (String, Double)) -> Bool in
//        first.1 > second.1
//    })
//    printCompoundValues(rankings: orderedStatRankings)
//}
//
//func printCompoundValues(rankings:[Dictionary<String, Double>.Element] ) {
//    print("==============================")
//    print("Compound Stat")
//    print("==============================")
//    for (champ, value) in rankings {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumSignificantDigits = 3
//        let newValue = formatter.string(for: value)
//        print("\(champ): \(newValue!)")
//    }
//}
//
////var mrRankings = [String:Double]()
////for (key, value) in championNamesDictionary {
////    if let champ = getChampionDetailsByID(championID: ChampionId(key)) {
////        let mr = champ.stats["spellblock"]
////        let mrGrowth = champ.stats["spellblockperlevel"]
////        let level18MR = mr!+17*mrGrowth!
////        mrRankings[value] = level18MR
////        
////    }
////}
////let newMRRankings = mrRankings.sorted(by:{
////    (first: (String, Double), second: (String, Double)) -> Bool in
////    first.1 > second.1
////})
////print("MR Rankings")
////for (mrChamp, value) in newMRRankings {
////    print("\(mrChamp): \(value)")
////}
////
////
////
////var tankyRankings = [String: Double]()
////
////for (champToTest, value) in newArmorRankings {
////    
////    let mrValue = mrRankings["\(champToTest)"]
////    let totalValue = value+mrValue!
////    tankyRankings[champToTest] = totalValue
////    
////}
////let newTankyRankings = tankyRankings.sorted(by: {
////    (first: (String, Double), second: (String, Double)) -> Bool in
////    first.1 > second.1
////})
//////print(newTankyRankings)
////print("Total Tankyness Rankings")
////
////for (tankyChamp, value) in newTankyRankings {
////    print("\(tankyChamp): \(value)")
////}
