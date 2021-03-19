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
                SearchBar(text: $viewModel.search).padding(.top)
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
        VStack{
            Spacer()
            Text("Carregando..")
            Spacer()
        }
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
