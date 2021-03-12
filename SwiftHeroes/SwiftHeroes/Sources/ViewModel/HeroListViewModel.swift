//
//  HeroListViewModel.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import SwiftUI

final class HeroListViewModel: ObservableObject {
    
    private let service: HeroService
    
    @Published var heroes: [Hero] = []
    @Published var loading: Bool = false
    @Published var search: String = "" { didSet {
        search(name: search)
    }}
    
    init(service: HeroService = HeroService()) {
        self.service = service
    }
    
    func onAppear() {
        loading = true
        service.getCharacters { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleHeroes(response.data.results)
            default:
                break
            }
        }
    }
    
    func loadMore() {
        service.getCharacters(offset: heroes.count) { [weak self] result in
            switch result {
            case .success(let response):
                print(response.data.results)
                self?.handleHeroes(response.data.results)
            default:
                break
            }
        }
    }
    
    func search(name: String) {
        loading = true
        
        service.getCharacters(name: name) { [weak self] result in
            switch result {
            
            case .success(let response):
                DispatchQueue.main.async { [weak self] in 
                    self?.heroes = response.data.results
                    self?.loading = false
                }
            default:
                break
            }
        }
    }
    
    private func handleHeroes(_ heroes: [Hero]) {
        DispatchQueue.main.async { [weak self] in
            self?.heroes += heroes
            self?.loading = false
        }
    }
}
