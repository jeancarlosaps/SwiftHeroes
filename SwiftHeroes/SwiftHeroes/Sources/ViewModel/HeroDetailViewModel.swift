//
//  HeroDetailViewModel.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/03/21.
//

import Foundation
import Combine

final class HeroDetailViewModel: ObservableObject {
    private let service: HeroServiceType
    private var subscription = Set<AnyCancellable>()
    private let heroID: Int
    
    @Published var comics: [Comic] = []
    
    init(heroID: Int, service: HeroServiceType = HeroService()) {
        self.heroID = heroID
        self.service = service
    }
    
    func onAppear() {
        service.getComics(id: heroID)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in () },
                  receiveValue: { comics in
                    self.comics = comics.data.results
                  })
            .store(in: &subscription)
    }
}
