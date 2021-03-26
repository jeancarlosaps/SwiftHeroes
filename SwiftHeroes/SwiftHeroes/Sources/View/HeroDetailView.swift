//
//  HeroDetailView.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 11/03/21.
//

import SwiftUI

struct HeroDetailView: View {
    let hero: Hero
    
    @ObservedObject var viewModel: HeroDetailViewModel
    
    init(hero: Hero) {
        self.hero = hero
        self.viewModel = HeroDetailViewModel(heroID: hero.id)
    }
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.comics) { comic in
                            ComicCell(comic: comic)
                        }
                    }
                }
            }.navigationTitle(hero.name)
            .padding()
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}

struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(hero: Hero(id: 1, name: "Spider", description: "Amigo da vizinhança", thumbnail: Thumbnail(path: "", extension: ""), series: Series(available: 10, returned: 10, collectionURI: "", items: [])))
    }
}
