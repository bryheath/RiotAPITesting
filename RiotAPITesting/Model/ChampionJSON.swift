//
//  ChampionJSON.swift
//  RiotAPITesting
//
//  Created by Bryan Heath on 9/28/22.
//  Copyright © 2022 Bryan Heath. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
///Users/bryanwork/2021 Apps/RiotAPITesting/RiotAPITesting/Model/ChampionJSON.swift
//   let championJson = try ChampionJson(json)

import Foundation

// MARK: - ChampionJson
public class ChampionJSON: Codable {
    public var type, format, version: String
    public var data: [String: ChampionData]

    public init(type: String, format: String, version: String, data: [String: ChampionData]) {
        self.type = type
        self.format = format
        self.version = version
        self.data = data
    }
}

// MARK: ChampionJson convenience initializers and mutators

public extension ChampionJSON {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChampionJSON.self, from: data)
        self.init(type: me.type, format: me.format, version: me.version, data: me.data)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        type: String? = nil,
        format: String? = nil,
        version: String? = nil,
        data: [String: ChampionData]? = nil
    ) -> ChampionJSON {
        return ChampionJSON(
            type: type ?? self.type,
            format: format ?? self.format,
            version: version ?? self.version,
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Datum
public class ChampionData: Codable {
    public var version, id, key, name: String
    public var title, blurb: String
    public var info: ChampionInfo
    public var image: ChampionImage
    public var tags: [String]
    public var partype: String
    public var stats: [String: Double]

    public init(version: String, id: String, key: String, name: String, title: String, blurb: String, info: ChampionInfo, image: ChampionImage, tags: [String], partype: String, stats: [String: Double]) {
        self.version = version
        self.id = id
        self.key = key
        self.name = name
        self.title = title
        self.blurb = blurb
        self.info = info
        self.image = image
        self.tags = tags
        self.partype = partype
        self.stats = stats
    }
}

// MARK: Datum convenience initializers and mutators

public extension ChampionData {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChampionData.self, from: data)
        self.init(version: me.version, id: me.id, key: me.key, name: me.name, title: me.title, blurb: me.blurb, info: me.info, image: me.image, tags: me.tags, partype: me.partype, stats: me.stats)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        version: String? = nil,
        id: String? = nil,
        key: String? = nil,
        name: String? = nil,
        title: String? = nil,
        blurb: String? = nil,
        info: ChampionInfo? = nil,
        image: ChampionImage? = nil,
        tags: [String]? = nil,
        partype: String? = nil,
        stats: [String: Double]? = nil
    ) -> ChampionData {
        return ChampionData(
            version: version ?? self.version,
            id: id ?? self.id,
            key: key ?? self.key,
            name: name ?? self.name,
            title: title ?? self.title,
            blurb: blurb ?? self.blurb,
            info: info ?? self.info,
            image: image ?? self.image,
            tags: tags ?? self.tags,
            partype: partype ?? self.partype,
            stats: stats ?? self.stats
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Image
public class ChampionImage: Codable {
    public var full, sprite, group: String
    public var x, y, w, h: Int

    public init(full: String, sprite: String, group: String, x: Int, y: Int, w: Int, h: Int) {
        self.full = full
        self.sprite = sprite
        self.group = group
        self.x = x
        self.y = y
        self.w = w
        self.h = h
    }
}

// MARK: Image convenience initializers and mutators

public extension ChampionImage {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChampionImage.self, from: data)
        self.init(full: me.full, sprite: me.sprite, group: me.group, x: me.x, y: me.y, w: me.w, h: me.h)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        full: String? = nil,
        sprite: String? = nil,
        group: String? = nil,
        x: Int? = nil,
        y: Int? = nil,
        w: Int? = nil,
        h: Int? = nil
    ) -> ChampionImage {
        return ChampionImage(
            full: full ?? self.full,
            sprite: sprite ?? self.sprite,
            group: group ?? self.group,
            x: x ?? self.x,
            y: y ?? self.y,
            w: w ?? self.w,
            h: h ?? self.h
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Info
public class ChampionInfo: Codable {
    public var attack, defense, magic, difficulty: Int

    public init(attack: Int, defense: Int, magic: Int, difficulty: Int) {
        self.attack = attack
        self.defense = defense
        self.magic = magic
        self.difficulty = difficulty
    }
}

// MARK: Info convenience initializers and mutators

public extension ChampionInfo {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ChampionInfo.self, from: data)
        self.init(attack: me.attack, defense: me.defense, magic: me.magic, difficulty: me.difficulty)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        attack: Int? = nil,
        defense: Int? = nil,
        magic: Int? = nil,
        difficulty: Int? = nil
    ) -> ChampionInfo {
        return ChampionInfo(
            attack: attack ?? self.attack,
            defense: defense ?? self.defense,
            magic: magic ?? self.magic,
            difficulty: difficulty ?? self.difficulty
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
