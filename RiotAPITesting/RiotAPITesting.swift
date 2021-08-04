//
//  RiotAPITesting.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/20/21.
//

import Foundation
import LeagueAPI

public let league: LeagueAPI = LeagueAPI(APIToken: "RGAPI-9b872625-3629-4e82-af68-b3eb2fd81a39")
public var preferredRegion: Region = Region.NA
public var preferredWorldRegion: WorldRegion {
    switch preferredRegion {
        case .NA, .BR, .LAN, .LAS, .OCE, .PBE:
            return .America
        case .KR, .JP:
            return .Asia
        case .EUNE, .EUW, .TR, .RU:
            return .Europe
    }
}
public var preferredSummoner: String = ""
public var matches: [MatchReference] = []


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
