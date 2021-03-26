//
//  ComicsResponse.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/03/21.
//

import Foundation

struct ComicsResponse: Codable {
    let data: ContentData
    
    struct ContentData: Codable {
        let total: Int
        let results: [Comic]
    }
}
