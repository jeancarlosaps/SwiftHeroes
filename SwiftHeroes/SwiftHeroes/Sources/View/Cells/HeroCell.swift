//
//  HeroCell.swift
//  SwiftHeroes
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 3/4/21.
//

import SwiftUI
import URLImage

struct HeroCell: View {
    var hero: Hero
    
    var body: some View {
        HStack {
            thumbView
            VStack {
                HStack {
                    Text(hero.name)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(hero.description)
                        .font(.subheadline)
                        .lineLimit(2)
                    Spacer()
                }
            }
        }
    }
    
    var thumbView: some View {
        URLImage(
            url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.extension)")!,
             content:  {
                $0.resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
         })
        .frame(width: 64, height: 64)
        .cornerRadius(4)
    }
}
