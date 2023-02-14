//
//  RiotAPITesting.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/20/21.
//

import Foundation
import LeagueAPI

public let league: League_API = League_API(APIToken: "RGAPI-5645c779-ea56-4b7e-8785-0b349493f188") // 1-31-22
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



