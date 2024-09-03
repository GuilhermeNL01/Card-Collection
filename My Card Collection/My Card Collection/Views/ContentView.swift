//
//  ContentView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import Combine

/// `ContentView` é a estrutura principal da interface de usuário do aplicativo.
/// Ela exibe uma barra de pesquisa para buscar cartas de Magic: The Gathering e
/// apresenta os resultados em uma lista. Se nenhum resultado for encontrado, uma
/// mensagem e uma imagem são exibidas.
struct ContentView: View {
    /// `viewModel` é uma instância de `ContentViewModel`, que gerencia o estado
    /// e a lógica de negócio para a `ContentView`.
    @StateObject private var viewModel = ContentViewModel()
    
    /// `modelContext` é um ambiente que fornece o contexto de modelo
    /// para operações de banco de dados ou armazenamento de estado.
    @Environment(\.modelContext) private var modelContext

    /// Inicializador personalizado que configura a aparência da `UINavigationBar`.
    init(){
        // Define a cor do título da barra de navegação.
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.accent]
    }
    
    /// Corpo da `ContentView`, responsável por construir a interface de usuário.
    var body: some View {
        NavigationView {
            VStack {
                // Barra de pesquisa para digitar a consulta e iniciar a busca de cartas.
                SearchBar(
                    text: $viewModel.searchQuery,
                    onSearch: viewModel.searchCards,
                    onEditingStart: {
                        // Limpa os resultados da busca e a consulta quando a edição começa.
                        viewModel.cards.removeAll()
                        viewModel.searchQuery = ""
                    }
                )
                
                // Exibe uma mensagem e imagem quando nenhuma carta é encontrada.
                if viewModel.cards.isEmpty {
                    VStack {
                        Image("cards")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding()
                            .rotationEffect(.degrees(viewModel.rotation))
                            .onTapGesture {
                                viewModel.handleTapGesture()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                } else {
                    // Exibe a lista de cartas encontradas.
                    List(viewModel.cards) { card in
                        // Navega para a tela de detalhes da carta quando um item da lista é tocado.
                        NavigationLink(destination: CardDetailView(
                            card: card,
                            addCardToCollection: { viewModel.addCardToCollection(card: $0, context: modelContext) },
                            hideAddButton: false
                        )) {
                            HStack(alignment: .top) {
                                // Exibe a imagem da carta, se disponível.
                                if let url = URL(string: card.imageUris.normal) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60, height: 80)
                                    .cornerRadius(8)
                                }
                                
                                // Exibe o nome e tipo da carta.
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(card.name)
                                        .font(.headline)
                                        .lineLimit(1)
                                    Text(card.typeLine)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.leading, 8)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            // Define o título da barra de navegação.
            .navigationTitle(NSLocalizedString("Card Search", comment: ""))
            .background(Color(.systemBackground))
        }
        // Estiliza a navegação para empilhar as telas uma sobre a outra.
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    /// Função privada para dispensar o teclado quando necessário.
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
