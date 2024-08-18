//
//  FilterSheetView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

struct FilterSheetView: View {
    @StateObject private var viewModel = FilterSheetViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Text(NSLocalizedString("Filter options", comment:""))
                .navigationTitle(NSLocalizedString("Filters", comment: ""))
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(NSLocalizedString("Cancel", comment: "")) {
                            viewModel.cancel()
                        }
                    }
                }
        }
    }
}
