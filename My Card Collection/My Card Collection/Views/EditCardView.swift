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
            TextField(NSLocalizedString("Card Name", comment: ""), text: $item.name)
            TextField(NSLocalizedString("Image URL", comment: ""), text: $item.imageUrl)
        }
        .navigationTitle(NSLocalizedString("Edit Card", comment: ""))
        .toolbar {
            Button(NSLocalizedString("Save", comment: "")) {
                viewModel.saveChanges(context: modelContext)
            }
        }
    }
}
