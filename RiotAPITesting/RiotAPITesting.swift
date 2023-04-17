//
//  RiotAPITesting.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/20/21.
//

import Foundation
import LeagueAPI

public let league: League_API = League_API(APIToken: "RGAPI-4306e57a-bcef-479d-a172-6dac331264ce") // 04-11-23
public var preferredRegion: Region = Region.NA
public var preferredWorldRegion: WorldRegion {
    switch preferredRegion {
        case .NA, .BR, .LAN, .LAS, .OCE, .PBE:
            return .America
        case .KR, .JP:
            return .Asia
        case .EUNE, .EUW, .TR, .RU:
            return .Europe
        default:
            return .America
    }
}

public let winColor:UIColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0.6956360672) //CC9900 Opacity 70%
public let lossColor:UIColor = #colorLiteral(red: 0.6717363, green: 0.0841416195, blue: 0, alpha: 0.7048924932) //990000 Opacity 70%
public let blueTeamColor:UIColor = #colorLiteral(red: 0.0009294916526, green: 0.02323836647, blue: 0.2609384656, alpha: 0.8019141393) //000033 Opacity 80%
public let redTeamColor:UIColor = #colorLiteral(red: 0.2638129294, green: 0.01383359917, blue: 0, alpha: 0.8019141393) //330000 Opacity 80%

public func formatQueue(mode: String) -> String {
    switch (mode) {
    case "Aram":
        return "ARAM"
    case "Ranked Solo 5v5":
        return "Solo/Duo"
    case "Blind Pick 5v5":
        return "Blind"
    case "Draft Pick 5v5":
        return "Draft"
    case "Ranked Flex 5v5":
        return "Flex"
    case "Arurf":
        return "ARURF"
    case "Ultimate Spellbook":
        return "Spellbook"
    case "Coop vs AI Intro":
        return "AI Intro"
    case "Coop vs AI Beginner":
        return "AI Beginner"
    case "Coop vs AI Intermediate":
        return "AI Intermediate"
    default:
        return mode
    }
    
}



public var preferredSummoner: String = "SunraiRW"
//OoDNhtz1YucubaketIqogTiU2_EVa0qaeyl_cUCvMiVY31eEqeIg59EmEpAMPnuc667AdKI-p_C1vQ
/*{
    "id": "bbG7MVAkzdJ1sGFA4_5gMG-i3uCIHXlA8kuOjtJXWG35qqM",
    "accountId": "56-nTcnBTly_qpchi4Q6Cfi0ZCDyw3IJ581gAFgpcxT1fVc",
    "puuid": "OoDNhtz1YucubaketIqogTiU2_EVa0qaeyl_cUCvMiVY31eEqeIg59EmEpAMPnuc667AdKI-p_C1vQ",
    "name": "SunraiRW",
    "profileIconId": 5426,
    "revisionDate": 1658865608000,
    "summonerLevel": 490
}*/

/* For Valorant
 {
     "id": "o6-G7WYvWu7ExlzRJIqvD-KPsL450vKmy26vwqoCFeRuvd64",
     "accountId": "7FQ7VWoJuVDR502zXQvKQDsoaBCq4TbLvaJkWko309BUsZt4jwMsbOkc",
     "puuid": "rU_mUxD7fXhGDWONEo_URheJeovXxDixuh8JcJP3q04xN_1SotFVJp4i4Z7tZdZPLyC2RabYF7DHvw",
     "name": "KittyRawpawsTTV",
     "profileIconId": 5181,
     "revisionDate": 1673824127000,
     "summonerLevel": 102
 }
 */



extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}

class ReplaceSegue: UIStoryboardSegue {

    override func perform() {
        source.navigationController?.setViewControllers([destination], animated: true)
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}



