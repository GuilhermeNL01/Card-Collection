//
//  SearchBar.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import Combine

struct SearchBar: View {
    @StateObject private var viewModel = SearchBarViewModel()
    @Binding var text: String
    let onSearch: () -> Void
    let onEditingStart: () -> Void // Novo parâmetro
    
    @State private var debounceCancellable: AnyCancellable?
    
    var body: some View {
        HStack {
            TextField("Search Cards", text: $text, onEditingChanged: { isEditing in
                if isEditing {
                    onEditingStart() // Chame a ação quando a edição começar
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
                .onChange(of: text) { newValue in
                    debounceCancellable?.cancel()
                    debounceCancellable = Just(newValue)
                        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                        .sink { _ in
                            onSearch()
                        }
                }
            
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
