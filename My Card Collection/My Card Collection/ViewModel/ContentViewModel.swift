//
//  ContentViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI
import Combine
import SwiftData

class ContentViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var searchQuery: String = ""
    @Published var tapCount: Int = 0
    @Published var rotation: Double = 0
    
    private let scryfallAPI = ScryfallAPI()
    
    func searchCards() {
        scryfallAPI.searchCards(query: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                self?.cards = result ?? []
            }
        }
    }
    
    func handleTapGesture() {
        tapCount += 1
        if tapCount == 4 {
            tapCount = 0
            withAnimation(.easeInOut(duration: 1.0)) {
                rotation += 360
            }
        }
    }
    
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
