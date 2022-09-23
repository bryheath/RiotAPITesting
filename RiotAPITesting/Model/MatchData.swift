//
//  MatchData.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/17/21.
//

import Foundation
import LeagueAPI

class MatchData: NSObject {
    
    var metadata: LOLMatchMetadata
    var info: MatchInfo
    var you: MatchParticipant
    

    init(match: Match, participant: Int) {

        self.metadata = match.metadata
        self.info = match.info
        self.you = match.info.participants[participant]
    }
}
