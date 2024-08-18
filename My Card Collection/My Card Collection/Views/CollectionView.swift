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
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
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
                                Text("Card ID: \(item.cardId)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.leading, 8)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteItems)
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
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = items[index]
            modelContext.delete(itemToDelete) // Remove the item from the context
        }
        do {
            try modelContext.save() // Save the changes
        } catch {
            print("Error saving after deletion: \(error.localizedDescription)")
        }
    }
}
