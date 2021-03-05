//
//  Hero.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

struct Hero: Codable, Equatable {
    let name: String
    let description: String
    let thumbnail: Thumbnail
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.name == rhs.name
    }
}
