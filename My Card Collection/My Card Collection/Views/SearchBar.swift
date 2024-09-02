//
//  SearchBar.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import Combine

/// `SearchBar` é uma view que fornece uma barra de pesquisa personalizável com funcionalidade de debounce.
/// Ela permite que o usuário digite um texto para pesquisa, execute uma ação de pesquisa e limpe o campo de texto.
struct SearchBar: View {
    /// `viewModel` é uma instância de `SearchBarViewModel`, que gerencia o estado da barra de pesquisa.
    @StateObject private var viewModel = SearchBarViewModel()
    
    /// `text` é um `Binding` que representa o texto inserido na barra de pesquisa. Ele é vinculado ao estado externo.
    @Binding var text: String
    
    /// `onSearch` é uma ação de callback que será executada quando o usuário confirmar a pesquisa.
    let onSearch: () -> Void
    
    /// `onEditingStart` é uma ação de callback que será executada quando o usuário iniciar a edição do campo de texto.
    let onEditingStart: () -> Void
    
    /// `debounceCancellable` é usado para gerenciar a operação de debounce, evitando que a pesquisa seja acionada a cada caractere digitado.
    @State private var debounceCancellable: AnyCancellable?
    
    /// Corpo da `SearchBar`, responsável por construir a interface de usuário.
    var body: some View {
        HStack {
            // Campo de texto para inserir a pesquisa
            TextField(NSLocalizedString("Search Cards", comment: ""), text: $text, onEditingChanged: { isEditing in
                if isEditing {
                    onEditingStart()
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
                    // Aplica debounce para a operação de pesquisa
                    debounceCancellable?.cancel()
                    debounceCancellable = Just(newValue)
                        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                        .sink { _ in
                            onSearch()
                        }
                }
            
            // Botão para limpar o texto inserido
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
