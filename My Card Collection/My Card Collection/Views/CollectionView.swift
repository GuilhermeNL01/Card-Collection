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

    @State private var searchText = ""
    @State private var showFilterSheet = false
    @State private var allItems: [CollectionItem] = []

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search Cards", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button(action: {
                        showFilterSheet.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .imageScale(.large)
                    }
                    .padding()
                }

                List {
                    ForEach(filteredItems) { item in
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
            .onAppear {
                allItems = items
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheetView()
            }
        }
    }

    private var filteredItems: [CollectionItem] {
        allItems.filter { item in
            searchText.isEmpty || item.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let itemToDelete = allItems[index]
            modelContext.delete(itemToDelete) // Remove the item from the context
        }
        do {
            try modelContext.save() // Save the changes
        } catch {
            print("Error saving after deletion: \(error.localizedDescription)")
        }
    }
}

struct FilterSheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Text("Filter options")
                .navigationTitle("Filters")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
        }
    }
}
