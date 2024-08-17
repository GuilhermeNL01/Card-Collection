//
//  CardDetailView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    let addCardToCollection: (Card) -> Void

    var body: some View {
        VStack {
            if let imageUrl = URL(string: card.imageUris.large) {
                AsyncImage(url: imageUrl) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxHeight: 400)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("Image not available")
                    .padding()
            }

            Text(card.name)
                .font(.largeTitle)
                .padding()

            Text(card.typeLine)
                .font(.title2)
                .foregroundColor(.gray)
                .padding()

            Text(card.oracleText)
                .font(.body)
                .padding()
            
            Button(action: {
                addCardToCollection(card)
            }) {
                Label("Add to Collection", systemImage: "plus")
            }
            .padding()
        }
        .navigationTitle(card.name)
    }
}
