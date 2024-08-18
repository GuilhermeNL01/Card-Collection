//
//  FilterSheetView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

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

