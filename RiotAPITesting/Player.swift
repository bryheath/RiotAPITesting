//
//  Player.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/13/21.
//

import Foundation

class Player: NSObject, Comparable {
    var number: Int
    var name: String?
    var champion: String?
    var dSpell: String?
    var fSpell: String?
    var team: String?
    var level: Int?
    var kills: Int?
    var deaths: Int?
    var assists: Int?
    var kda: Double?
    var lane: String?
    var role: String?
    var position: String?
    
    
    init(number: Int, name: String?, champion: String?, dSpell: String?, fSpell: String?, team: String?, level: Int?, kills: Int?, deaths: Int?, assists: Int?, kda: Double?, lane: String?, role: String?, position: String?) {
        self.number = number
        self.name = name
        self.champion = champion
        self.dSpell = dSpell
        self.fSpell = fSpell
        self.team = team
        self.level = level
        self.kills = kills
        self.deaths = deaths
        self.assists = assists
        self.kda = kda
        self.lane = lane
        self.role = role
        self.position = position
        
        
        
    }
    
    func printDesc() {
        print("********************")
        print("Participant #\(number+1 ): \(name ?? "")") // 1 added for UI reasons
        print("Champion: \(champion ?? "")")
        print("D: \(dSpell ?? "")")
        print("F: \(fSpell ?? "")")
        print("Team: \(team ?? "")")
        print("Level: \(level ?? 0)")
        if kills != nil && deaths != nil && assists != nil && kda != nil {
            print("KDA: \(kills!)/\(deaths!)/\(assists!) (\(kda!))")
        }
        
        
        
        if let lane = lane {print("Lane: \(lane)")}
        if let role = role {print("Role: \(role)")}
        if let position = position{print("Position: \(position)")}
    }
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.number == rhs.number
    }
    
    static func <(lhs: Player, rhs: Player) -> Bool {
        return lhs.number < rhs.number
    }
    
    
    
}
