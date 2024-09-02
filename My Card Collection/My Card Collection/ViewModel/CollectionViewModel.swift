//
//  CollectionViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import SwiftData

/**
 `CollectionViewModel` é uma classe que gerencia a lógica e o estado da coleção de cartas no aplicativo "My Card Collection". Ela implementa o protocolo `ObservableObject`, permitindo que a interface do usuário observe e reaja a mudanças nas propriedades publicadas.

 ## Propriedades:
 - `searchText`: Uma string que armazena o texto digitado pelo usuário para pesquisar itens na coleção.
 - `showFilterSheet`: Um booleano que controla a exibição de uma folha de filtro na interface.
 - `allItems`: Um array de `CollectionItem` que armazena todos os itens da coleção.

 ## Computed Properties:
 - `filteredItems`: Um array filtrado de `CollectionItem` que retorna apenas os itens cujo nome corresponde ao texto da pesquisa.

 ## Métodos:
 - `deleteItems(at offsets: IndexSet, context: ModelContext)`: Exclui itens da coleção com base nos índices fornecidos, e persiste a exclusão no contexto de dados.
 - `loadItems(from items: [CollectionItem])`: Carrega os itens fornecidos na propriedade `allItems`.

 ## Uso:
 Este ViewModel gerencia o estado da coleção de cartas, oferecendo funcionalidade para filtrar itens com base em uma pesquisa, excluir itens, e carregar itens em massa. Ele é central para a gestão da coleção no aplicativo, facilitando operações como pesquisa, exclusão e exibição dos itens.

 ## Observações:
 - `ModelContext`: Uma abstração para o contexto de dados, usada para persistir as mudanças feitas nos itens da coleção.
 - `CollectionItem`: Um modelo que representa um item da coleção, incluindo propriedades como o nome da carta.
 */
class CollectionViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var showFilterSheet: Bool = false
    @Published var allItems: [CollectionItem] = []
    
    /**
     Computa e retorna os itens filtrados com base no `searchText`. Se `searchText` estiver vazio, retorna todos os itens.
     */
    var filteredItems: [CollectionItem] {
        allItems.filter { item in
            searchText.isEmpty || item.name.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    /**
     Exclui os itens da coleção com base nos índices fornecidos e salva as mudanças no `ModelContext`.

     - Parameters:
       - offsets: Conjunto de índices dos itens a serem excluídos.
       - context: O contexto de dados onde as alterações serão persistidas.
     */
    func deleteItems(at offsets: IndexSet, context: ModelContext) {
        for index in offsets {
            let itemToDelete = allItems[index]
            context.delete(itemToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error saving after deletion: \(error.localizedDescription)")
        }
    }
    
    /**
     Carrega os itens fornecidos na propriedade `allItems`, substituindo os itens atuais.

     - Parameter items: Um array de `CollectionItem` que será carregado em `allItems`.
     */
    func loadItems(from items: [CollectionItem]) {
        allItems = items
    }
}
