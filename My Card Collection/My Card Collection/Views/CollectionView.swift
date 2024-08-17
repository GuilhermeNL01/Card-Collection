//
//  CollectionView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    @Query private var items: [CollectionItem]

    var body: some View {
        NavigationView {
            List(items) { item in
                HStack {
                    if let url = URL(string: item.imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text(item.name)
                }
            }
            .navigationTitle("My Collection")
        }
    }
}
