//
//  CollectionViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import SwiftData

class CollectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var showFilterSheet: Bool = false
    @Published var allItems: [CollectionItem] = []
    
    var filteredItems: [CollectionItem] {
        allItems.filter { item in
            searchText.isEmpty || item.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func deleteItems(at offsets: IndexSet, context: ModelContext) {
        for index in offsets {
            let itemToDelete = allItems[index]
            context.delete(itemToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error saving after deletion: \(error.localizedDescription)")
        }
    }
    
    func loadItems(from items: [CollectionItem]) {
        allItems = items
    }
}
