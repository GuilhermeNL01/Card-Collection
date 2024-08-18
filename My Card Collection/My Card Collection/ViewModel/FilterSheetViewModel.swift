//
//  FilterSheetViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

class FilterSheetViewModel: ObservableObject {
    @Environment(\.dismiss) var dismiss
    
    func cancel() {
        dismiss()
    }
}
