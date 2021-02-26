//
//  CharactersResponse.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

struct CharactersResponse: Codable {
    let data: ContentData
    
    struct ContentData: Codable {
        let total: Int
    }
}
