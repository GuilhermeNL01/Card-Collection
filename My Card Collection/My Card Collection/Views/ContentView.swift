//
//  ContentView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var cards: [Card] = []
    @State private var searchQuery: String = ""
    
    @Environment(\.modelContext) private var modelContext
    private let scryfallAPI = ScryfallAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchQuery, onSearch: searchCards)
                
                List(cards) { card in
                    NavigationLink(destination: CardDetailView(card: card, addCardToCollection: addCardToCollection)) {
                        VStack(alignment: .leading) {
                            Text(card.name)
                                .font(.headline)
                            Text(card.typeLine)
                                .font(.subheadline)
                            if let url = URL(string: card.imageUris.normal) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Card Search")
        }
    }
    
    private func searchCards() {
        scryfallAPI.searchCards(query: searchQuery) { result in
            DispatchQueue.main.async {
                self.cards = result ?? []
            }
        }
    }
    
    private func addCardToCollection(card: Card) {
        let newItem = CollectionItem(cardId: card.id, name: card.name, imageUrl: card.imageUris.normal)
        modelContext.insert(newItem)
        
        do {
            try modelContext.save() 
        } catch {
            print("Error saving card: \(error.localizedDescription)")
        }
    }
}
