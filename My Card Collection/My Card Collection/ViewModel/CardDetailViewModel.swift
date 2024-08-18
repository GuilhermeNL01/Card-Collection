//
//  CardDetailViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

class CardDetailViewModel: ObservableObject {
    @Published var isAdded: Bool = false
    @Published var showAlert: Bool = false
    
    private let addedCardsKey = "addedCards"

    func addCardToCollection(card: Card, addCardAction: (Card) -> Void) {
        // Adiciona a carta à coleção
        addCardAction(card)
        
        // Marca a carta como adicionada
        isAdded = true
        showAlert = true
        
        // Persiste a imagem da carta
        saveCardImage(card: card)
    }
    
    private func saveCardImage(card: Card) {
        // Carrega URLs existentes das cartas adicionadas
        var addedCards = UserDefaults.standard.array(forKey: addedCardsKey) as? [String] ?? []
        
        // Adiciona a URL da imagem da nova carta
        if !addedCards.contains(card.imageUris.normal) {
            addedCards.append(card.imageUris.normal)
            UserDefaults.standard.set(addedCards, forKey: addedCardsKey)
        }
    }
    
    func loadAddedCards() -> [String] {
        return UserDefaults.standard.array(forKey: addedCardsKey) as? [String] ?? []
    }
}
