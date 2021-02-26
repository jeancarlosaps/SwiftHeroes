//
//  SwiftHeroesApp.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/02/21.
//

import SwiftUI

@main
struct SwiftHeroesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear(perform: {
                let service = HeroeService()
                
                service.getCharacters()
            })
        }
    }
}
