//
//  CardDetailView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI

struct CardDetailView: View {
    let card: Card
    let addCardToCollection: (Card) -> Void
    let hideAddButton: Bool
    
    @StateObject private var viewModel = CardDetailViewModel()

    var body: some View {
        ScrollView {
            Spacer()
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
                
                // Botão para adicionar à coleção
                if !hideAddButton {
                    Button(action: {
                        viewModel.addCardToCollection(card: card, addCardAction: addCardToCollection)
                    }) {
                        Text("+ Add to collection")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.purple)
                            .scaleEffect(viewModel.isAdded ? 1.2 : 1.0)
                    }
                    .padding()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isAdded = false
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text("Card Added"), message: Text("\(card.name) has been added to your collection."), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(card.name)
    }
}
