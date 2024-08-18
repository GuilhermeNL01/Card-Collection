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
    @StateObject private var viewModel: EditCardViewModel

    init(item: Binding<CollectionItem>) {
        self._item = item
        self._viewModel = StateObject(wrappedValue: EditCardViewModel(item: item.wrappedValue))
    }

    var body: some View {
        Form {
            TextField("Card Name", text: $item.name)
            TextField("Image URL", text: $item.imageUrl)
        }
        .navigationTitle("Edit Card")
        .toolbar {
            Button("Save") {
                viewModel.saveChanges(context: modelContext)
            }
        }
    }
}
