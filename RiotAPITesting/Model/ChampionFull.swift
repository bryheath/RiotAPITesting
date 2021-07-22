// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let championFull = try? newJSONDecoder().decode(ChampionFull.self, from: jsonData)

import Foundation

// MARK: - ChampionFull
public struct ChampionFull: Codable {
    let type: TypeEnum
    let format, version: String
    let data: [String: Datum]
    let keys: [String: String]
}

public struct Champion: Codable {
    let type: TypeEnum
    let format, version: String
    let data: [String: Datum]
}

// MARK: - Datum
public struct Datum: Codable {
    let id, key, name, title: String
    let image: Image
    let skins: [Skin]
    let lore, blurb: String
    let allytips, enemytips: [String]
    let tags: [Tag]
    let partype: String
    let info: Info
    let stats: [String: Double]
    let spells: [Spell]
    let passive: Passive
    let recommended: [JSONAny]
}

// MARK: - Image
public struct Image: Codable {
    let full: String
    let sprite: Sprite
    let group: TypeEnum
    let x, y, w, h: Int
}

enum TypeEnum: String, Codable {
    case champion = "champion"
    case passive = "passive"
    case spell = "spell"
}

enum Sprite: String, Codable {
    case champion0PNG = "champion0.png"
    case champion1PNG = "champion1.png"
    case champion2PNG = "champion2.png"
    case champion3PNG = "champion3.png"
    case champion4PNG = "champion4.png"
    case champion5PNG = "champion5.png"
    case passive0PNG = "passive0.png"
    case passive1PNG = "passive1.png"
    case passive2PNG = "passive2.png"
    case passive3PNG = "passive3.png"
    case passive4PNG = "passive4.png"
    case passive5PNG = "passive5.png"
    case spell0PNG = "spell0.png"
    case spell10PNG = "spell10.png"
    case spell11PNG = "spell11.png"
    case spell12PNG = "spell12.png"
    case spell13PNG = "spell13.png"
    case spell14PNG = "spell14.png"
    case spell15PNG = "spell15.png"
    case spell1PNG = "spell1.png"
    case spell2PNG = "spell2.png"
    case spell3PNG = "spell3.png"
    case spell4PNG = "spell4.png"
    case spell5PNG = "spell5.png"
    case spell6PNG = "spell6.png"
    case spell7PNG = "spell7.png"
    case spell8PNG = "spell8.png"
    case spell9PNG = "spell9.png"
}

// MARK: - Info
public struct Info: Codable {
    let attack, defense, magic, difficulty: Int
}

// MARK: - Passive
public struct Passive: Codable {
    let name, description: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case name
        case description
        case image
    }
}

// MARK: - Skin
public struct Skin: Codable {
    let id: String
    let num: Int
    let name: String
    let chromas: Bool
}

// MARK: - Spell
public struct Spell: Codable {
    let id, name, description, tooltip: String
    let leveltip: Leveltip?
    let maxrank: Int
    let cooldown: [Double]
    let cooldownBurn: String
    let cost: [Int]
    let costBurn: String
    let datavalues: Datavalues
    let effect: [[Double]?]
    let effectBurn: [String?]
    let vars: [JSONAny]
    let costType, maxammo: String
    let range: [Int]
    let rangeBurn: String
    let image: Image
    let resource: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case tooltip, leveltip, maxrank, cooldown, cooldownBurn, cost, costBurn, datavalues, effect, effectBurn, vars, costType, maxammo, range, rangeBurn, image, resource
    }
}

// MARK: - Datavalues
public struct Datavalues: Codable {
}

// MARK: - Leveltip
public struct Leveltip: Codable {
    let label, effect: [String]
}

enum Tag: String, Codable {
    case assassin = "Assassin"
    case fighter = "Fighter"
    case mage = "Mage"
    case marksman = "Marksman"
    case support = "Support"
    case tank = "Tank"
}
