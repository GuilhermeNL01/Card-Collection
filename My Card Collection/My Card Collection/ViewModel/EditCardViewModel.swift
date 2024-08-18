//
//  EditCardViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import SwiftData

class EditCardViewModel: ObservableObject {
    @Published var item: CollectionItem
    
    init(item: CollectionItem) {
        self.item = item
    }
    
    func saveChanges(context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
