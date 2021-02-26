//
//  HTTPTask.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

enum HTTPTask {
    case requestPlain
    case requestParameters(parameters: [String: Any])
}
