//
//  OfflineData.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/21/21.
//

import Foundation
import LeagueAPI

public var cachedPatch = "12.18.1"
public var currentPatch = ""
public var championsDictionary = [Long: ChampionData]()
//public var championKeysDictionary = [String:]
//public var championNamesDictionary: [Long: String] = [
//    266: "Aatrox", 103: "Ahri", 84: "Akali", 166: "Akshan", 12: "Alistar", 32: "Amumu", 34: "Anivia", 1: "Annie", 523: "Aphelios", 22: "Ashe", 136: "Aurelion Sol", 268: "Azir", 432: "Bard", 200: "Bel'Veth", 53: "Blitzcrank", 63: "Brand", 201: "Braum", 51: "Caitlyn", 164: "Camille", 69: "Cassiopeia", 31: "Cho'Gath", 42: "Corki", 122: "Darius", 131: "Diana", 36: "Dr. Mundo", 119: "Draven", 245: "Ekko", 60: "Elise", 28: "Evelynn", 81: "Ezreal", 9: "Fiddlesticks", 114: "Fiora", 105: "Fizz", 3: "Galio", 41: "Gangplank", 86: "Garen", 150: "Gnar", 79: "Gragas", 104: "Graves", 887: "Gwen", 120: "Hecarim", 74: "Heimerdinger", 420: "Illaoi", 39: "Irelia", 427: "Ivern", 40: "Janna", 59: "Jarvan IV", 24: "Jax", 126: "Jayce", 202: "Jhin", 222: "Jinx", 145: "Kai'Sa", 429: "Kalista", 43: "Karma", 30: "Karthus", 38: "Kassadin", 55: "Katarina", 10: "Kayle", 141: "Kayn", 85: "Kennen", 121: "Kha'Zix", 203: "Kindred", 240: "Kled", 96: "Kog'Maw", 7: "LeBlanc", 64: "Lee Sin", 89: "Leona", 876: "Lillia", 127: "Lissandra", 236: "Lucian", 117: "Lulu", 99: "Lux", 54: "Malphite", 90: "Malzahar", 57: "Maokai", 11: "Master Yi", 21: "Miss Fortune", 82: "Mordekaiser", 25: "Morgana", 267: "Nami", 75: "Nasus", 111: "Nautilus", 518: "Neeko", 76: "Nidalee", 895: "Nilah", 56: "Nocturne", 20: "Nunu & Willump", 2: "Olaf", 61: "Orianna", 516: "Ornn", 80: "Pantheon", 78: "Poppy", 555: "Pyke", 246: "Qiyana", 133: "Quinn", 497: "Rakan", 33: "Rammus", 421: "Rek'Sai", 526: "Rell", 888: "Renata Glasc", 58: "Renekton", 107: "Rengar", 92: "Riven", 68: "Rumble", 13: "Ryze", 360: "Samira", 113: "Sejuani", 235: "Senna", 147: "Seraphine", 875: "Sett", 35: "Shaco", 98: "Shen", 102: "Shyvana", 27: "Singed", 14: "Sion", 15: "Sivir", 72: "Skarner", 37: "Sona", 16: "Soraka", 50: "Swain", 517: "Sylas", 134: "Syndra", 223: "Tahm Kench", 163: "Taliyah", 91: "Talon", 44: "Taric", 17: "Teemo", 412: "Thresh", 18: "Tristana", 48: "Trundle", 23: "Tryndamere", 4: "Twisted Fate", 29: "Twitch", 77: "Udyr", 6: "Urgot", 110: "Varus", 67: "Vayne", 45: "Veigar", 161: "Vel'Koz", 711: "Vex", 254: "Vi", 234: "Viego", 112: "Viktor", 8: "Vladimir", 106: "Volibear", 19: "Warwick", 62: "Wukong", 498: "Xayah", 101: "Xerath", 5: "Xin Zhao", 157: "Yasuo", 777: "Yone", 83: "Yorick", 350: "Yuumi", 154: "Zac", 238: "Zed", 221: "Zeri", 115: "Ziggs", 26: "Zilean", 142: "Zoe", 143: "Zyra"]
//public var championJSONNames: [Long: String] = [
//    266: "Aatrox", 103: "Ahri", 84: "Akali", 166: "Akshan", 12: "Alistar", 32: "Amumu", 34: "Anivia", 1: "Annie", 523: "Aphelios", 22: "Ashe", 136: "AurelionSol", 268: "Azir", 432: "Bard", 200: "Belveth", 53: "Blitzcrank", 63: "Brand", 201: "Braum", 51: "Caitlyn", 164: "Camille", 69: "Cassiopeia", 31: "Chogath", 42: "Corki", 122: "Darius", 131: "Diana", 36: "DrMundo", 119: "Draven", 245: "Ekko", 60: "Elise", 28: "Evelynn", 81: "Ezreal", 9: "Fiddlesticks", 114: "Fiora", 105: "Fizz", 3: "Galio", 41: "Gangplank", 86: "Garen", 150: "Gnar", 79: "Gragas", 104: "Graves", 887: "Gwen", 120: "Hecarim", 74: "Heimerdinger", 420: "Illaoi", 39: "Irelia", 427: "Ivern", 40: "Janna", 59: "JarvanIV", 24: "Jax", 126: "Jayce", 202: "Jhin", 222: "Jinx", 145: "Kaisa", 429: "Kalista", 43: "Karma", 30: "Karthus", 38: "Kassadin", 55: "Katarina", 10: "Kayle", 141: "Kayn", 85: "Kennen", 121: "Khazix", 203: "Kindred", 240: "Kled", 96: "KogMaw", 7: "Leblanc", 64: "LeeSin", 89: "Leona", 876: "Lillia", 127: "Lissandra", 236: "Lucian", 117: "Lulu", 99: "Lux", 54: "Malphite", 90: "Malzahar", 57: "Maokai", 11: "MasterYi", 21: "MissFortune", 82: "Mordekaiser", 25: "Morgana", 267: "Nami", 75: "Nasus", 111: "Nautilus", 518: "Neeko", 76: "Nidalee", 895: "Nilah", 56: "Nocturne", 20: "Nunu", 2: "Olaf", 61: "Orianna", 516: "Ornn", 80: "Pantheon", 78: "Poppy", 555: "Pyke", 246: "Qiyana", 133: "Quinn", 497: "Rakan", 33: "Rammus", 421: "RekSai", 526: "Rell", 888: "Renata Glasc", 58: "Renekton", 107: "Rengar", 92: "Riven", 68: "Rumble", 13: "Ryze", 360: "Samira", 113: "Sejuani", 235: "Senna", 147: "Seraphine", 875: "Sett", 35: "Shaco", 98: "Shen", 102: "Shyvana", 27: "Singed", 14: "Sion", 15: "Sivir", 72: "Skarner", 37: "Sona", 16: "Soraka", 50: "Swain", 517: "Sylas", 134: "Syndra", 223: "TahmKench", 163: "Taliyah", 91: "Talon", 44: "Taric", 17: "Teemo", 412: "Thresh", 18: "Tristana", 48: "Trundle", 23: "Tryndamere", 4: "TwistedFate", 29: "Twitch", 77: "Udyr", 6: "Urgot", 110: "Varus", 67: "Vayne", 45: "Veigar", 161: "Velkoz", 711: "Vex", 254: "Vi", 234: "Viego", 112: "Viktor", 8: "Vladimir", 106: "Volibear", 19: "Warwick", 62: "MonkeyKing", 498: "Xayah", 101: "Xerath", 5: "XinZhao", 157: "Yasuo", 777: "Yone", 83: "Yorick", 350: "Yuumi", 154: "Zac", 238: "Zed", 221: "Zeri", 115: "Ziggs", 26: "Zilean", 142: "Zoe", 143: "Zyra"]

public var summonerSpellDictionary: [Long: String] = [
    1: "Cleanse", 3: "Exhaust", 4: "Flash", 6: "Ghost", 7: "Heal", 11: "Smite", 12: "Teleport",
    13: "Clarity", 14: "Ignite", 21: "Barrier", 30: "To the King!", 31: "Poro Toss", 32: "Mark",
    39: "Mark", 54: "Placeholder", 55:"Placeholder and Attack-Smite"]

public var summonerSpellFileNames: [Long: String] = [
    1: "SummonerBoost", 3: "SummonerExhaust", 4: "SummonerFlash", 6: "SummonerHaste", 7: "SummonerHeal", 11: "SummonerSmite", 12: "SummonerTeleport", 13: "SummonerMana", 14: "SummonerDot", 21: "SummonerBarrier", 30: "SummonerPoroRecall", 31: "SummonerPoroThrow", 32: "SummonerSnowball", 39: "SummonerSnowURFSnowball_Mark", 54: "Summoner_UltBookPlaceholder", 55: "Summoner_UltBookSmitePlaceholder"]

public func createChampionsDictionary() {
    do {
        if let path = Bundle.main.path(forResource: "champion", ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONDecoder().decode(ChampionJSON.self, from: data)
            let results = jsonResult.data
            
            for champion in results {
                let champ = champion.value
                if let key = Long(champ.key) {
                    championsDictionary[key] = champ
                }
            }
            
        }
    } catch {
        print("Error in createChampionsDictionary - \(error)")
    }
}

func getCurrentPatchVersion() {
    league.lolAPI.getPatchVersion() { (currentPatchVersion, errorMsg) in
        if let currentPatchVersion = currentPatchVersion {
            currentPatch = currentPatchVersion
            print("Current Patch: \(currentPatchVersion), Cached Patch: \(cachedPatch)")
        }
    }
}

public func checkCacheVersion(championName: String) {
    getCurrentPatchVersion()
    if cachedPatch < currentPatch {
    }
}

func fileModificationDate(path:String) -> Date? {
    do {
        let attr = try FileManager.default.attributesOfItem(atPath: path)
        return attr[FileAttributeKey.modificationDate] as? Date
    } catch {
        return nil
    }
}

public func getRuneImage(runeId: RuneId, completion: @escaping (UIImage?) -> Void) {
    league.lolAPI.getRune(by: runeId) { (rune, errorMsg) in
        if let rune = rune {
            rune.image.getImage() { (image, error) in
                completion(image)
            }
        }
    }
    
}
public func getRunePathImage(runePathId: RunePathId, completion: @escaping (UIImage?) -> Void) {
    league.lolAPI.getRunePath(by: runePathId) { (runePath, errorMsg) in
        if let runePath = runePath {
            runePath.image.getImage() { (image, error) in
                completion(image)
            }
        }
    }
    
}
public func getChampIdString(championId: ChampionId) -> String? {
    if championsDictionary.keys.contains(championId.value) {
        return championsDictionary[championId.value]!.id
    }
    return nil
}
public func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
    if let champIdString = getChampIdString(championId: championId) {
        if let image = UIImage(named: champIdString) {
                completion(image)
            } else {
                league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
                    if let champion = champion, let defaultSkin = champion.images?.square {
                        defaultSkin.getImage() { (image, error) in
                            completion(image)
                        }
                    } else {
                        print("getChampionImageFailed: \(errorMsg ?? "No Error Description")")
                    }
            }
        }
    }
}
public func getItemImage(itemId: ItemId, completion: @escaping (UIImage?) -> Void) {
    league.lolAPI.getItem(by: itemId) { (item, errorMsg) in
        if let item = item {
            item.image.getImage() { (image, _) in
                completion(image)
            }
        }
    }
    
}
public func getSummonerSpellImage(summonerSpellId: SummonerSpellId, completion: @escaping (UIImage?) -> Void) {
    league.lolAPI.getSummonerSpell(by: summonerSpellId) { (summonerSpell, errorMsg) in
        if let summonerSpell = summonerSpell {
            summonerSpell.image.getImage() { (image, _) in
                completion(image)
            }
        } else {
            print("getSummonerSpellImage Request Failed cause: \(errorMsg ?? "No error description")")
        }
    }
}
public func getSummonerSpells(participant: MatchParticipant, completion: @escaping (UIImage?, UIImage?) -> Void) {
    var dSpell: UIImage?
    var fSpell: UIImage?
    var received: Int = 0
    getSummonerSpellImage(summonerSpellId: participant.summoner1Id) { image in
        dSpell = image
        received += 1
        if received == 2 {
            completion(dSpell, fSpell)
        }
    }
    getSummonerSpellImage(summonerSpellId: participant.summoner2Id) { image in
        fSpell = image
        received += 1
        if received == 2 {
            completion(dSpell, fSpell)
        }
    }
}

/*
 Challenge Testing Functions
 */

public func allChallengesConfig() {
    league.lolAPI.getAllChallengesConfig(on: preferredRegion) { (allChallenges, errorMsg) in
        if let allChallenges = allChallenges {
            var count = 0
            for challenge in allChallenges {
                count += 1
                print("challenge #\(count)")
                print(challenge)
            }
        } else {
            print("allChallengesConfig failed \(String(describing: errorMsg))")
        }
            
    }
}

public func allChallengesPercentiles() {
    league.lolAPI.getAllChallengesPercentiles(on: preferredRegion) { (challengesArray, errorMsg) in
        if let challengesArray = challengesArray {
            for challenge in challengesArray {
                print("\(challenge.key) : \n\(challenge.value)")
            }
        } else {
            print("challengesPercentiles Failed")
            print(String(describing: errorMsg))
        }
    }
}

public func challengeConfig() {
    league.lolAPI.getChallengeConfig(by: ChallengeId(103100), on: preferredRegion) { (challenge, errorMsg) in
        if let challenge = challenge {
            print(challenge.debugDescription)
        } else {
            print("challengeConfig Failed \(String(describing: errorMsg))")
        }
    }
}

public func challengeLeaderboard() {
    league.lolAPI.getChallengeLeaderboard(by: ChallengeId(203303), for: .master, on: preferredRegion) { (leaderboardArray, errorMsg) in
        if let leaderboardArray = leaderboardArray {
            print(String(describing:leaderboardArray))
        } else {
            print("challengeLeaderboard Failed \(String(describing: errorMsg))")
        }
    }
}

public func challengePercentiles() {
    league.lolAPI.getChallengePercentiles(by: ChallengeId(203303), on: preferredRegion) { (thresholds, errorMsg) in
        if let thresholds = thresholds {
            print(String(describing: thresholds))
        } else {
            print("challengePercentiles Failed: \(String(describing: errorMsg))")
        }
    }
}

public func challengePlayerInfo() {
    league.lolAPI.getSummoner(byName: preferredSummoner, on: preferredRegion) { (summoner, errorMsg) in
        if let summoner = summoner {
            league.lolAPI.getChallengePlayerInfo(by: summoner.puuid, on: preferredRegion) { (player, errorMsg) in
                if let player = player {
                    print(player)
                } else {
                    print("playerInfo failed: \(String(describing: errorMsg))")
                }
            }
        } else {
            print("challengePlayerInfo-getSummoner Failed: \(String(describing: errorMsg))")
        }
       
    }
    
}
