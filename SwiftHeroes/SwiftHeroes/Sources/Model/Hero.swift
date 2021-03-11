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
    let series: Series
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.name == rhs.name
    }
}

struct Series: Codable, Identifiable {
    var id: UUID {
        return UUID()
    }
    
    let available: Int
    let returned: Int
    let collectionURI: String
    let items: [Item]
    
    struct Item: Codable, Identifiable {
        var id: String {
            name
        }
        
        let resourceURI: String
        let name: String
    }
}

