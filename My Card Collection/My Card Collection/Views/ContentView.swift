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
                        
                        Text(NSLocalizedString("No cards found. Try searching for something.", comment: ""))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                } else {
                    List(viewModel.cards) { card in
                        NavigationLink(destination: CardDetailView(
                            card: card,
                            addCardToCollection: { viewModel.addCardToCollection(card: $0, context: modelContext) },
                            hideAddButton: false
                        )) {
                            HStack(alignment: .top) {
                                if let url = URL(string: card.imageUris.normal) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60, height: 80)
                                    .cornerRadius(8)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(card.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                    Text(card.typeLine)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.leading, 8)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("Card Search", comment: ""))
            .background(Color(.systemBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
