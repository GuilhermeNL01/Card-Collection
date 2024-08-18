//
//  SearchBar.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Combine
import SwiftUI

struct SearchBar: View {
    @StateObject private var viewModel = SearchBarViewModel()
    @Binding var text: String
    let onSearch: () -> Void
    
    @State private var debounceCancellable: AnyCancellable?
    
    var body: some View {
        HStack {
            TextField("Search Cards", text: $text, onEditingChanged: { _ in
                debounceCancellable?.cancel()
                debounceCancellable = Just(text)
                    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                    .sink { _ in
                        onSearch()
                    }
            }, onCommit: onSearch)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding(.vertical, 8)

            if !text.isEmpty {
                Button(action: {
                    viewModel.clearText()
                    text = viewModel.text
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
