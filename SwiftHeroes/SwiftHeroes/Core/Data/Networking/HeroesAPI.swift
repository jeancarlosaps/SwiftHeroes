//
//  HeroesAPI.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

enum HeroesAPI {
    case getCharacters
}

extension HeroesAPI: APIRequest {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public")!
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/characters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCharacters:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: HTTPTask {
        switch self {
        case .getCharacters:
           return .requestParameters(parameters: ["apikey" : "13bf281feb4982518242da6b4066437d"])
        }
    }
}
