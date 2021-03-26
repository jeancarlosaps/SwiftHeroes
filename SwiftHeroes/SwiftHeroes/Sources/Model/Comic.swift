//
//  Comic.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/03/21.
//

import Foundation

struct Comic: Codable, Identifiable {
    var id: String {
        title
    }
    
    let title: String
    let thumbnail: Thumbnail
}
