//
//  CardDetailView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI

/// `CardDetailView` é uma view que exibe os detalhes de uma carta de Magic: The Gathering.
/// Ela permite visualizar a imagem da carta e, opcionalmente, adicionar a carta à coleção do usuário.
struct CardDetailView: View {
    /// `card` é a carta que será exibida na view.
    let card: Card
    
    /// `addCardToCollection` é uma função que será chamada quando o usuário adicionar a carta à coleção.
    let addCardToCollection: (Card) -> Void
    
    /// `hideAddButton` determina se o botão para adicionar a carta à coleção deve ser exibido ou não.
    let hideAddButton: Bool
    
    /// `viewModel` é uma instância de `CardDetailViewModel`, que gerencia o estado e a lógica de negócio para a `CardDetailView`.
    @StateObject private var viewModel = CardDetailViewModel()

    /// Corpo da `CardDetailView`, responsável por construir a interface de usuário.
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Verifica se há uma URL válida para a imagem da carta. Se sim, exibe a imagem; caso contrário, exibe um texto de erro.
                if let imageUrl = URL(string: card.imageUris.normal) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                            .scaledToFit()
                            .shadow(radius: 10)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    } placeholder: {
                        // Exibe um indicador de progresso enquanto a imagem é carregada.
                        ProgressView()
                            .frame(maxHeight: 400)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    // Exibe uma mensagem quando a imagem não está disponível.
                    Text(NSLocalizedString("Image not available", comment: ""))
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                }
                
                // Exibe o botão "Adicionar à Coleção" se `hideAddButton` for `false`.
                if !hideAddButton {
                    Button(action: {
                        // Adiciona a carta à coleção do usuário.
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
                        // Reseta a animação do botão quando a view aparece.
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.isAdded = false
                        }
                    }
                    // Exibe um alerta confirmando que a carta foi adicionada à coleção.
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
