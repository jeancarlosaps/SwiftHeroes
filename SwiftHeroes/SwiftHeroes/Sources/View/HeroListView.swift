//
//  HeroListView.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import SwiftUI

struct HeroListView: View {
    @ObservedObject var viewModel: HeroListViewModel
    
    init(viewModel: HeroListViewModel = HeroListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.loading {
                    loadingView
                } else {
                    listView
                }
            }.navigationTitle("Heróis")
        }.onAppear {
            viewModel.onAppear()
        }
    }
    
    var loadingView: some View {
        Text("Carregando..")
    }
    
    var listView: some View {
        List(viewModel.heroes, id: \.name) { hero in
            NavigationLink(
                destination: HeroDetailView(hero: hero) )
            {
                HeroCell(hero: hero)
                    .onAppear {
                        if hero == viewModel.heroes.last {
                            viewModel.loadMore()
                        }
                    }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
