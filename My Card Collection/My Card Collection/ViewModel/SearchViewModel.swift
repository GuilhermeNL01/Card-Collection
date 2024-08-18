//
//  SearchViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import Combine
import SwiftUI

class SearchBarViewModel: ObservableObject {
    @Published var text: String = ""
    
    func clearText() {
        text = ""
    }
}
