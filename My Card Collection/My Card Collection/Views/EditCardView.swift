//
//  EditCardView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

/// `EditCardView` é uma view que permite ao usuário editar as informações de um item da coleção de cartas.
struct EditCardView: View {
    /// `item` é uma ligação (`Binding`) a um item da coleção de cartas que será editado.
    @Binding var item: CollectionItem
    
    /// `modelContext` é o contexto do modelo de dados fornecido pelo ambiente, usado para salvar as alterações no banco de dados.
    @Environment(\.modelContext) private var modelContext
    
    /// `viewModel` é o `ViewModel` responsável por gerenciar a lógica de edição da carta.
    @StateObject private var viewModel: EditCardViewModel

    /// Inicializador personalizado que cria um `EditCardView` com um `CollectionItem` ligado.
    /// - Parameter item: Um `Binding` ao item da coleção que será editado.
    init(item: Binding<CollectionItem>) {
        self._item = item
        self._viewModel = StateObject(wrappedValue: EditCardViewModel(item: item.wrappedValue))
    }

    /// Corpo da `EditCardView`, responsável por construir a interface de usuário.
    var body: some View {
        Form {
            // Campo de texto para editar o nome da carta
            TextField(NSLocalizedString("Card Name", comment: ""), text: $item.name)
            
            // Campo de texto para editar a URL da imagem da carta
            TextField(NSLocalizedString("Image URL", comment: ""), text: $item.imageUrl)
        }
        .navigationTitle(NSLocalizedString("Edit Card", comment: ""))
        .toolbar {
            // Botão de salvar as alterações feitas na carta
            Button(NSLocalizedString("Save", comment: "")) {
                viewModel.saveChanges(context: modelContext)
            }
        }
    }
}
