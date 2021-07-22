//
//  RiotAPITesting.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/20/21.
//

import Foundation
import LeagueAPI

public let league: LeagueAPI = LeagueAPI(APIToken: "RGAPI-e6c6306c-a090-4aeb-8b6e-23f23c0fd423")
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
