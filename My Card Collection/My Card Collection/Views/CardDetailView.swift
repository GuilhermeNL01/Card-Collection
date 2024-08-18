//
//  CardDetailView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import UIKit

struct CardDetailView: View {
    let card: Card
    let addCardToCollection: (Card) -> Void
    
    @State private var isAdded = false
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Exibe a imagem da carta
                if let imageUrl = URL(string: card.imageUris.normal) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                            .frame(maxHeight: 400)
                    }
                } else {
                    Text("Image not available")
                        .padding()
                }

                // Nome da carta
                Text(card.name)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 16)

                // Tipo da carta
                Text(card.typeLine)
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.bottom, 4)

                // Botão para adicionar à coleção
                Button(action: {
                    addCardToCollection(card)
                    
                    // Trigger Haptic Feedback
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isAdded = true
                    }
                    showAlert = true
                }) {
                    Text("+ Add to collection")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.purple)
                        .scaleEffect(isAdded ? 1.2 : 1.0)
                }
                .padding()
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isAdded = false
                    }
                }

                // Texto da carta (oracle text)
                Text(card.oracleText)
//                    .font(.system(.body, design: .rounded))
                    .font(FontManager.planewalker(size:.title3))
                
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(card.name)
    }
}
