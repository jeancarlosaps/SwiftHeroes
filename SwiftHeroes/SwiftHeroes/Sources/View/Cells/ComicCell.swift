//
//  ComicCell.swift
//  SwiftHeroes
//
//  Created by Jean Carlos Antônio Pereira dos Santos on 25/03/21.
//

import SwiftUI
import URLImage

struct ComicCell: View {
    let comic: Comic
    
    var body: some View {
        VStack {
            URLImage(
                url: URL(string: "\(comic.thumbnail.path).\(comic.thumbnail.extension)")!,
                 content:  {
                    $0.resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
             })
            .frame(width: 96, height: 128)
            .cornerRadius(4)
            
            Text(comic.title)
        }
    }
}
