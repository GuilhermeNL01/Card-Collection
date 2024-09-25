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
    
    /// Enum para os estilos de imagem disponíveis.
    enum ImageStyle: String, CaseIterable {
        case small, normal, large, png, artCrop, borderCrop
        
        var title: String {
            switch self {
            case .small: return "Small"
            case .normal: return "Normal"
            case .large: return "Large"
            case .png: return "PNG"
            case .artCrop: return "Art Crop"
            case .borderCrop: return "Border Crop"
            }
        }
    }
    
    /// Variável de estado para armazenar o estilo de imagem selecionado.
    @State private var selectedStyle: ImageStyle = .normal

    /// Corpo da `CardDetailView`, responsável por construir a interface de usuário.
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Picker para seleção do estilo da imagem.
                Picker("Select Image Style", selection: $selectedStyle) {
                    ForEach(ImageStyle.allCases, id: \.self) { style in
                        Text(style.title).tag(style)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Verifica se há uma URL válida para a imagem da carta com base no estilo selecionado. Se sim, exibe a imagem; caso contrário, exibe um texto de erro.
                if let imageUrl = URL(string: imageUrlForStyle(selectedStyle)) {
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
    
    /// Retorna a URL da imagem com base no estilo selecionado.
    ///
    /// - Parameter style: O estilo da imagem selecionado.
    /// - Returns: A URL da imagem correspondente ao estilo selecionado.
    private func imageUrlForStyle(_ style: ImageStyle) -> String {
        switch style {
        case .small:
            return card.imageUris.small
        case .normal:
            return card.imageUris.normal
        case .large:
            return card.imageUris.large
        case .png:
            return card.imageUris.png
        case .artCrop:
            return card.imageUris.artCrop
        case .borderCrop:
            return card.imageUris.borderCrop
        }
    }
}
