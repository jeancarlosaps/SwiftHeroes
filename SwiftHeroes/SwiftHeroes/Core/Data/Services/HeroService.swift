//
//  HeroeService.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import Foundation

protocol HeroServiceType {
    func getCharacters()
}

struct HeroService: HeroServiceType {
    
    private var provider: APIProvider<HeroesAPI>
    
    init(provider: APIProvider<HeroesAPI> = APIProvider<HeroesAPI>()) {
        self.provider = provider
    }
    
    func getCharacters() {
        provider.request(.getCharacters) { (result) in
            switch result {
            case .success(let data): print(decode(CharactersResponse.self, data: data.data))
                case .failure(let error): print(error)
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
