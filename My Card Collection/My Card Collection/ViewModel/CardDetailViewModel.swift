//
//  CardDetailViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

/**
 `CardDetailViewModel` é uma classe que gerencia a lógica de negócios para a tela de detalhes de uma carta no aplicativo "My Card Collection". Ela implementa o protocolo `ObservableObject`, permitindo que a interface do usuário observe e reaja a mudanças nas propriedades publicadas.

 ## Propriedades:
 - `isAdded`: Um booleano que indica se a carta foi adicionada à coleção.
 - `showAlert`: Um booleano que controla a exibição de um alerta informando que a carta foi adicionada.
 - `addedCardsKey`: Uma constante que define a chave usada para armazenar URLs de imagens de cartas adicionadas no `UserDefaults`.

 ## Métodos:
 - `addCardToCollection(card: Card, addCardAction: (Card) -> Void)`: Adiciona a carta à coleção, marca a carta como adicionada, exibe um alerta e salva a imagem da carta.
 - `saveCardImage(card: Card)`: Salva a URL da imagem da carta no `UserDefaults` se ela ainda não tiver sido salva.
 - `loadAddedCards() -> [String]`: Carrega e retorna uma lista de URLs de imagens de cartas adicionadas da `UserDefaults`.

 ## Dependências:
 - `Card`: Um modelo que representa uma carta de Magic: The Gathering.
 - `UserDefaults`: Utilizado para armazenar e recuperar dados persistentes, como URLs de imagens de cartas adicionadas.

 ## Observação:
 Este ViewModel se concentra em gerenciar o estado relacionado ao processo de adição de uma carta à coleção, incluindo a persistência da imagem da carta e a exibição de alertas na interface.
 */
class CardDetailViewModel: ObservableObject {
    @Published var isAdded: Bool = false
    @Published var showAlert: Bool = false
    
    private let addedCardsKey = "addedCards"

    /**
     Adiciona a carta à coleção, atualiza o estado e salva a imagem da carta.

     - Parameters:
       - card: A carta a ser adicionada à coleção.
       - addCardAction: Uma ação de fechamento que adiciona a carta à coleção.
     */
    func addCardToCollection(card: Card, addCardAction: (Card) -> Void) {
        // Adiciona a carta à coleção
        addCardAction(card)
        
        // Marca a carta como adicionada
        isAdded = true
        showAlert = true
        
        // Persiste a imagem da carta
        saveCardImage(card: card)
    }
    
    /**
     Salva a URL da imagem da carta no UserDefaults se ela ainda não tiver sido salva.

     - Parameter card: A carta cuja imagem será salva.
     */
    private func saveCardImage(card: Card) {
        // Carrega URLs existentes das cartas adicionadas
        var addedCards = UserDefaults.standard.array(forKey: addedCardsKey) as? [String] ?? []
        
        // Adiciona a URL da imagem da nova carta
        if !addedCards.contains(card.imageUris.normal) {
            addedCards.append(card.imageUris.normal)
            UserDefaults.standard.set(addedCards, forKey: addedCardsKey)
        }
    }
    
    /**
     Carrega e retorna uma lista de URLs de imagens de cartas adicionadas a partir do UserDefaults.

     - Returns: Uma lista de strings representando URLs de imagens de cartas adicionadas.
     */
    func loadAddedCards() -> [String] {
        return UserDefaults.standard.array(forKey: addedCardsKey) as? [String] ?? []
    }
}
