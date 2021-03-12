//
//  HeroeService.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

protocol HeroServiceType {
    func getCharacters(offset: Int?, completion: @escaping (Result<CharactersResponse, Error>) -> Void)
}

struct HeroService: HeroServiceType {
    
    private var provider: APIProvider<HeroesAPI>
    
    init(provider: APIProvider<HeroesAPI> = APIProvider<HeroesAPI>()) {
        self.provider = provider
    }
    
    func getCharacters(offset: Int? = nil, completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        provider.request(.getCharacters(offset)) { result in
            switch result {
            case .success(let response):
                completion(.success(decode(CharactersResponse.self, data: response.data)!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCharacters(name: String, completion: @escaping (Result<CharactersResponse, Error>) -> Void) {
        guard name.isEmpty == false else { getCharacters(completion: completion)
            return
        }
        
        provider.request(.getCharactersByName(name)) { result in
            switch result {
            case .success(let response):
                completion(.success(decode(CharactersResponse.self, data: response.data)!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decode<T: Decodable>(_ type: T.Type, data: Data?) -> T? {
        
        guard let data = data else { return nil }
        
        do {
            let result = try JSONDecoder().decode(type, from: data)
            
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
}
