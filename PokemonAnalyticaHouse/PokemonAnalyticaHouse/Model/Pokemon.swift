//
//  Pokemon.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 27.03.2023.
//

import Foundation

struct Response: Codable {
    let count: Int
    let previous: String?
    let results: [MyResult]
}

struct MyResult: Codable {
    let name: String
    let url: String
}

struct Ability: Codable {
    let name: String
}

struct AbilityDetail: Codable {
    let ability: Ability
}

struct Pokemon: Codable {
    let name: String
    let abilities: [AbilityDetail]
    let sprites: Sprites
    
    struct Sprites: Codable {
        let front_default: String?
    }
}
