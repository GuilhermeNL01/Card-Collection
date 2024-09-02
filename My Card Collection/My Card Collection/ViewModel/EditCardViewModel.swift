//
//  EditCardViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import SwiftData

/**
 `EditCardViewModel` é uma classe que gerencia a lógica para editar um item específico da coleção de cartas no aplicativo "My Card Collection". Ela implementa o protocolo `ObservableObject`, permitindo que a interface do usuário observe e reaja a mudanças na propriedade publicada.

 ## Propriedades:
 - `item`: Um objeto `CollectionItem` que representa o item da coleção que está sendo editado.

 ## Inicializador:
 - `init(item: CollectionItem)`: Inicializa o ViewModel com o item da coleção que será editado.

 ## Métodos:
 - `saveChanges(context: ModelContext)`: Salva as alterações feitas no item da coleção e persiste essas mudanças no contexto de dados.

 ## Uso:
 Este ViewModel é utilizado quando o usuário deseja editar um item da coleção. Ele armazena o item em edição e fornece um método para salvar as alterações feitas, garantindo que as mudanças sejam persistidas no contexto de dados.

 ## Observações:
 - `ModelContext`: Uma abstração para o contexto de dados, usada para persistir as mudanças feitas nos itens da coleção.
 - `CollectionItem`: Um modelo que representa um item da coleção, incluindo propriedades como o nome da carta, imagem, etc.
 */
class EditCardViewModel: ObservableObject {
    @Published var item: CollectionItem
    
    /**
     Inicializa o ViewModel com o item da coleção a ser editado.

     - Parameter item: O `CollectionItem` que será editado.
     */
    init(item: CollectionItem) {
        self.item = item
    }
    
    /**
     Salva as alterações feitas no item da coleção e persiste essas mudanças no contexto de dados.

     - Parameter context: O contexto de dados onde as alterações serão persistidas.
     */
    func saveChanges(context: ModelContext) {
        do {
            try context.save()
        } catch {
            print("Failed to save changes: \(error.localizedDescription)")
        }
    }
}
