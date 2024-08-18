//
//  ContentView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(
                    text: $viewModel.searchQuery,
                    onSearch: viewModel.searchCards,
                    onEditingStart: {
                        viewModel.cards.removeAll()
                        viewModel.searchQuery = ""
                    }
                )
                
                if viewModel.cards.isEmpty {
                    VStack {
                        Image("cards")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding()
                            .rotationEffect(.degrees(viewModel.rotation))
                            .onTapGesture {
                                viewModel.handleTapGesture()
                            }
                        
                        Text("No cards found. Try searching for something.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                } else {
                    List(viewModel.cards) { card in
                        NavigationLink(destination: CardDetailView(card: card, addCardToCollection: { viewModel.addCardToCollection(card: $0, context: modelContext) }, hideAddButton: false)) {
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
            .onTapGesture {
                dismissKeyboard()
            }
        }
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
