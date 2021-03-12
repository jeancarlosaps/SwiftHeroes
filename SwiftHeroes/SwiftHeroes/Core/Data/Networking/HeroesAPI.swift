//
//  HeroesAPI.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

enum HeroesAPI {
    case getCharacters(Int?)
    case getCharactersByName(String)
}

extension HeroesAPI: APIRequest {
    var baseURL: URL {
        return URL(string: "https://gateway.marvel.com:443/v1/public")!
    }
    
    var path: String {
        switch self {
        default :
            return "/characters"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var task: HTTPTask {
        switch self {
        case .getCharacters(let offset):
            guard let offset = offset else { return .requestPlain }
            return .requestParameters(parameters: ["offset": offset])
            
        case .getCharactersByName(let name):
            return .requestParameters(parameters: ["nameStartsWith": name])
        }
    }
}
