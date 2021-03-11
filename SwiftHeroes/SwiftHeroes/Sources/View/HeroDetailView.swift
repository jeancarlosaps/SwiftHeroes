//
//  HeroDetailView.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 11/03/21.
//

import SwiftUI

struct HeroDetailView: View {
    
    let hero: Hero
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(hero.series.items) { item in
                            Text(item.name)
                        }
                    }
                }
            }.navigationTitle(hero.name)
        }
    }
}

struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView(hero: Hero(name: "Spider", description: "Amigo da vizinhança", thumbnail: Thumbnail(path: "", extension: ""), series: Series(available: 10, returned: 10, collectionURI: "", items: [])))
    }
}
