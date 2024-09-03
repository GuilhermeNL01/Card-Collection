//
//  CollectionView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

/// `CollectionView` é uma view que exibe a coleção de cartas do usuário em uma lista, com suporte a pesquisa, navegação e exclusão de itens.
struct CollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [CollectionItem]
    @StateObject private var viewModel = CollectionViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if items.isEmpty {
                    Spacer()
                    Text("Ainda não há cartas adicionadas.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Text("Clique em + para adicionar pastas.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    HStack {
                        TextField(NSLocalizedString("Search Cards", comment: ""), text: $viewModel.searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                    
                    List {
                        ForEach(viewModel.filteredItems) { item in
                            NavigationLink(destination: CardDetailView(
                                card: Card(id: item.cardId, name: item.name, typeLine: item.type_Line, imageUris: Card.ImageURIs(
                                    small: item.imageUrl, normal: item.imageUrl, large: item.imageUrl, png: "", artCrop: "", borderCrop: ""), oracleText: ""
                                ),
                                addCardToCollection: { _ in },
                                hideAddButton: true
                            )) {
                                HStack {
                                    if let url = URL(string: item.imageUrl) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width: 60, height: 60)
                                        }
                                    } else {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text("\(item.type_Line)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.leading, 8)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .onDelete { indexSet in
                            viewModel.deleteItems(at: indexSet, context: modelContext)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .onAppear {
                viewModel.loadItems(from: items)
            }
            .navigationTitle("My Collection")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Ação do botão de adicionar
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}
