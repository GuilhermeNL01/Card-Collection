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
    @State private var tapCount: Int = 0
    @State private var rotation: Double = 0
    
    @Environment(\.modelContext) private var modelContext
    private let scryfallAPI = ScryfallAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchQuery, onSearch: searchCards)
                
                if cards.isEmpty {
                    VStack {
                        Image("cards")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding()
                            .rotationEffect(.degrees(rotation))
                            .onTapGesture {
                                tapCount += 1
                                if tapCount == 4 {
                                    tapCount = 0
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        rotation += 360
                                    }
                                }
                            }
                        
                        Text("No cards found. Try searching for something.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                } else {
                    List(cards) { card in
                        NavigationLink(destination: CardDetailView(card: card, addCardToCollection: addCardToCollection, hideAddButton: false)) {
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
            }
            .navigationTitle("Card Search")
            .background(Color(.colorBG))
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
        let newItem = CollectionItem(cardId: card.id, name: card.name, imageUrl: card.imageUris.normal, type_Line: card.typeLine)
        modelContext.insert(newItem)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving card: \(error.localizedDescription)")
        }
    }
}
