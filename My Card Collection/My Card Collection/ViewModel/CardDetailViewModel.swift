//
//  CardDetailViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

class CardDetailViewModel: ObservableObject {
    @Published var isAdded = false
    @Published var showAlert = false
    
    func addCardToCollection(card: Card, addCardAction: (Card) -> Void) {
        addCardAction(card)
        
        // Trigger Haptic Feedback
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        withAnimation(.easeInOut(duration: 0.2)) {
            isAdded = true
        }
        showAlert = true
    }
}
