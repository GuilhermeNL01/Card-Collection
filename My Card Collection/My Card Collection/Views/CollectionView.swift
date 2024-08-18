//
//  CollectionView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

struct CollectionView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [CollectionItem]
    @StateObject private var viewModel = CollectionViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search Cards", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        viewModel.showFilterSheet.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                    }
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
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("My Collection")
                .toolbar {
                    EditButton()
                }
                .background(Color(UIColor.systemGroupedBackground))
                .cornerRadius(12)
                .shadow(radius: 10)
            }
            .onAppear {
                viewModel.loadItems(from: items)
            }
            .sheet(isPresented: $viewModel.showFilterSheet) {
                FilterSheetView()
            }
        }
    }
}
