//
//  EditCardView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

struct EditCardView: View {
    @Binding var item: CollectionItem
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Form {
            TextField("Card Name", text: $item.name)
            TextField("Image URL", text: $item.imageUrl)
        }
        .navigationTitle("Edit Card")
        .toolbar {
            Button("Save") {
                do {
                    try modelContext.save()
                } catch {
                    print("Failed to save changes: \(error.localizedDescription)")
                }
            }
        }
    }
}
