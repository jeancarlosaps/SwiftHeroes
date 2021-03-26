//
//  HeroListViewModel.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import SwiftUI
import Combine

final class HeroListViewModel: ObservableObject {
    
    private let service: HeroServiceType
    private var subscription = Set<AnyCancellable>()
    
    @Published var heroes: [Hero] = []
    @Published var loading: Bool = false
    @Published var search: String = "" { didSet {
        search(name: search)
    }}
    
    init(service: HeroServiceType = HeroService()) {
        self.service = service
    }
    
    func onAppear() {
        loading = true
        service.getCharacters()
            .receive(on: RunLoop.main)
            .sink { (error) in
                print(error)
            } receiveValue: { (charactersResponse) in
                self.handleHeroes(charactersResponse.data.results)
            }
            .store(in: &subscription)
    }
    
    func loadMore() {
        service.getCharacters(offset: heroes.count)
            .receive(on: RunLoop.main)
            .sink { (error) in
                print(error)
            } receiveValue: { (charactersResponse) in
                self.handleHeroes(charactersResponse.data.results)
            }
            .store(in: &subscription)
    }
    
    func search(name: String) {
        loading = true
        
        service.getCharacters(name: name)
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .sink { (error) in
                print(error)
            } receiveValue: { (charactersResponse) in
                self.heroes = charactersResponse.data.results
                self.loading = false
            }
            .store(in: &subscription)
    }
    
    private func handleHeroes(_ heroes: [Hero]) {
        self.heroes += heroes
        loading = false
    }
}
