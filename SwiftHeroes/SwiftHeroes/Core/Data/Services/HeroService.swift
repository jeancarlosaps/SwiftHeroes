//
//  HeroeService.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation
import Combine

protocol HeroServiceType {
    func getCharacters(offset: Int?) -> AnyPublisher<CharactersResponse, Error>
}

struct HeroService: HeroServiceType {
    
    private var provider: APIProvider<HeroesAPI>
    
    init(provider: APIProvider<HeroesAPI> = APIProvider<HeroesAPI>()) {
        self.provider = provider
    }
    
    func getCharacters(offset: Int? = nil) -> AnyPublisher<CharactersResponse, Error> {
        provider.request(.getCharacters(offset))
            .map { $0.data }
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getCharacters(name: String) -> AnyPublisher<CharactersResponse, Error> {
        guard name.isEmpty == false else {
            return getCharacters()
        }
        
        return provider.request(.getCharactersByName(name))
            .map { $0.data }
            .decode(type: CharactersResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
