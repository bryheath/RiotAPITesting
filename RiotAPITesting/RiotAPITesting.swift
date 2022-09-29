//
//  RiotAPITesting.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/20/21.
//

import Foundation
import LeagueAPI

public let league: League_API = League_API(APIToken: "RGAPI-d017b665-2037-4162-aa16-b3eeb1ca7fd9") //09-29-22
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
