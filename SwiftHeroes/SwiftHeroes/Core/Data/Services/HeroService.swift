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
    func getCharacters(name: String) -> AnyPublisher<CharactersResponse, Error>
    func getComics(id: Int) -> AnyPublisher<ComicsResponse, Error>
}

extension HeroServiceType {
    func getCharacters() -> AnyPublisher<CharactersResponse, Error> {
        return getCharacters(offset: nil)
    }
}

struct HeroService: HeroServiceType {
    func getComics(id: Int) -> AnyPublisher<ComicsResponse, Error> {
        provider.request(.getComics(id))
            .map { $0.data }
            .decode(type: ComicsResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
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
