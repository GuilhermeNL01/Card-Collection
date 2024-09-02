//
//  ContentViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import Combine
import SwiftData

/**
 `ContentViewModel` é uma classe que gerencia a lógica de negócios para a tela principal do aplicativo "My Card Collection". Ela utiliza o padrão de design MVVM (Model-View-ViewModel) e implementa o protocolo `ObservableObject` para permitir que a interface do usuário observe e reaja a mudanças nos dados.

 ## Propriedades:
 - `cards`: Um array de objetos `Card` que contém os resultados da busca de cartas.
 - `searchQuery`: Uma string que armazena a consulta de busca inserida pelo usuário.
 - `tapCount`: Um contador que rastreia o número de toques na tela.
 - `rotation`: Um valor de rotação (em graus) utilizado para animar a interface.

 ## Métodos:
 - `searchCards()`: Realiza uma busca de cartas na API Scryfall usando o `searchQuery` e atualiza a propriedade `cards` com os resultados.
 - `handleTapGesture()`: Lida com gestos de toque na tela. Quando o usuário toca quatro vezes, reseta o contador de toques e inicia uma animação de rotação de 360 graus.
 - `addCardToCollection(card: Card, context: ModelContext)`: Adiciona uma carta à coleção do usuário e salva as alterações no contexto de dados.

 ## Dependências:
 - `ScryfallAPI`: Um objeto que lida com as requisições à API Scryfall.
 - `Card`: Um modelo que representa uma carta de Magic: The Gathering.
 - `CollectionItem`: Um modelo que representa um item na coleção do usuário.
 - `ModelContext`: Um contexto de dados utilizado para inserir e salvar objetos no banco de dados.
 */
class ContentViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var searchQuery: String = ""
    @Published var tapCount: Int = 0
    @Published var rotation: Double = 0
    
    private let scryfallAPI = ScryfallAPI()
    
    /// Realiza uma busca de cartas na API Scryfall com base na `searchQuery` atual e atualiza a lista de `cards`.
    func searchCards() {
        scryfallAPI.searchCards(query: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                self?.cards = result ?? []
            }
        }
    }
    
    /// Lida com um gesto de toque. Se o usuário tocar quatro vezes, uma animação de rotação de 360 graus é iniciada.
    func handleTapGesture() {
        tapCount += 1
        if tapCount == 4 {
            tapCount = 0
            withAnimation(.easeInOut(duration: 1.0)) {
                rotation += 360
            }
        }
    }
    
    /// Adiciona uma carta à coleção do usuário e salva a alteração no contexto de dados.
    /// - Parameters:
    ///   - card: A carta a ser adicionada à coleção.
    ///   - context: O contexto de dados onde a carta será salva.
    func addCardToCollection(card: Card, context: ModelContext) {
        let newItem = CollectionItem(cardId: card.id, name: card.name, imageUrl: card.imageUris.normal, type_Line: card.typeLine)
        context.insert(newItem)
        
        do {
            try context.save()
        } catch {
            print("Error saving card: \(error.localizedDescription)")
        }
    }
}
