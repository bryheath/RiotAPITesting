//
//  OfflineData.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/21/21.
//

import Foundation
import LeagueAPI

public var championNamesDictionary: [Long:String] = [
    266: "Aatrox", 103: "Ahri", 84: "Akali", 166: "Akshan", 12: "Alistar", 32: "Amumu", 34: "Anivia", 1: "Annie", 523: "Aphelios", 22: "Ashe", 136: "Aurelion Sol", 268: "Azir", 432: "Bard", 53: "Blitzcrank", 63: "Brand", 201: "Braum", 51: "Caitlyn", 164: "Camille", 69: "Cassiopeia", 31: "Cho'Gath", 42: "Corki", 122: "Darius", 131: "Diana", 36: "Dr. Mundo", 119: "Draven", 245: "Ekko", 60: "Elise", 28: "Evelynn", 81: "Ezreal", 9: "Fiddlesticks", 114: "Fiora", 105: "Fizz", 3: "Galio", 41: "Gangplank", 86: "Garen", 150: "Gnar", 79: "Gragas", 104: "Graves", 887: "Gwen", 120: "Hecarim", 74: "Heimerdinger", 420: "Illaoi", 39: "Irelia", 427: "Ivern", 40: "Janna", 59: "Jarvan IV", 24: "Jax", 126: "Jayce", 202: "Jhin", 222: "Jinx", 145: "Kai'Sa", 429: "Kalista", 43: "Karma", 30: "Karthus", 38: "Kassadin", 55: "Katarina", 10: "Kayle", 141: "Kayn", 85: "Kennen", 121: "Kha'Zix", 203: "Kindred", 240: "Kled", 96: "Kog'Maw", 7: "LeBlanc", 64: "Lee Sin", 89: "Leona", 876: "Lillia", 127: "Lissandra", 236: "Lucian", 117: "Lulu", 99: "Lux", 54: "Malphite", 90: "Malzahar", 57: "Maokai", 11: "Master Yi", 21: "Miss Fortune", 82: "Mordekaiser", 25: "Morgana", 267: "Nami", 75: "Nasus", 111: "Nautilus", 518: "Neeko", 76: "Nidalee", 56: "Nocturne", 20: "Nunu & Willump", 2: "Olaf", 61: "Orianna", 516: "Ornn", 80: "Pantheon", 78: "Poppy", 555: "Pyke", 246: "Qiyana", 133: "Quinn", 497: "Rakan", 33: "Rammus", 421: "Rek'Sai", 526: "Rell", 58: "Renekton", 107: "Rengar", 92: "Riven", 68: "Rumble", 13: "Ryze", 360: "Samira", 113: "Sejuani", 235: "Senna", 147: "Seraphine", 875: "Sett", 35: "Shaco", 98: "Shen", 102: "Shyvana", 27: "Singed", 14: "Sion", 15: "Sivir", 72: "Skarner", 37: "Sona", 16: "Soraka", 50: "Swain", 517: "Sylas", 134: "Syndra", 223: "Tahm Kench", 163: "Taliyah", 91: "Talon", 44: "Taric", 17: "Teemo", 412: "Thresh", 18: "Tristana", 48: "Trundle", 23: "Tryndamere", 4: "Twisted Fate", 29: "Twitch", 77: "Udyr", 6: "Urgot", 110: "Varus", 67: "Vayne", 45: "Veigar", 161: "Vel'Koz", 254: "Vi", 234: "Viego", 112: "Viktor", 8: "Vladimir", 106: "Volibear", 19: "Warwick", 62: "Wukong", 498: "Xayah", 101: "Xerath", 5: "Xin Zhao", 157: "Yasuo", 777: "Yone", 83: "Yorick", 350: "Yuumi", 154: "Zac", 238: "Zed", 115: "Ziggs", 26: "Zilean", 142: "Zoe", 143: "Zyra"]

public var summonerSpellDictionary = [Long: String]()

public func getChampionDetailsByID(championID: ChampionId) -> Datum? {
    let longNum = Long(championID.value)
    let index = championNamesDictionary.index(forKey: longNum)
    let championName = championNamesDictionary[index!].value
    if let path = Bundle.main.path(forResource: championName, ofType: "json") {
        do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode(Champion.self, from: data)
            
            return jsonResult.data[championName]
              
          } catch {
               print(error)
            return nil
          }
    }
    
//
//    if let path = Bundle.main.path(forResource: "championFull", ofType: "json") {
//        print(path)
//        do {
//              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let jsonResult = try JSONDecoder().decode(ChampionFull.self, from: data)
//
//
//
//          } catch {
//               print(error)
//          }
//    }
    return nil
}
