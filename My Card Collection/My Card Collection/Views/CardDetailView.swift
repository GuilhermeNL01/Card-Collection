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
            VStack(spacing: 16) {
                if let imageUrl = URL(string: card.imageUris.normal) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                            .scaledToFit()
                            .shadow(radius: 10)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    } placeholder: {
                        ProgressView()
                            .frame(maxHeight: 400)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text(NSLocalizedString("Image not available", comment: ""))
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                }
                
                if !hideAddButton {
                    Button(action: {
                        viewModel.addCardToCollection(card: card, addCardAction: addCardToCollection)
                    }) {
                        Text(NSLocalizedString("+ Add to Collection", comment:""))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.purple)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .scaleEffect(viewModel.isAdded ? 1.1 : 1.0)
                    }
                    .padding()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isAdded = false
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(title: Text(NSLocalizedString("Card Added", comment: "")), message: Text("\(card.name) \(NSLocalizedString("has been added to your collection.", comment: ""))"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(card.name)
    }
}
