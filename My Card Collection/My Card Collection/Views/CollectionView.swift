//
//  CollectionView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

/// `CollectionView` é uma view que exibe a coleção de cartas do usuário em uma lista, com suporte a pesquisa, navegação e exclusão de itens.
struct CollectionView: View {
    /// `modelContext` é o contexto do modelo de dados fornecido pelo ambiente, usado para manipular o banco de dados.
    @Environment(\.modelContext) private var modelContext
    
    /// `items` é uma consulta ao banco de dados que busca todos os itens da coleção.
    @Query private var items: [CollectionItem]
    
    /// `viewModel` é o `ViewModel` responsável por gerenciar o estado e a lógica da `CollectionView`.
    @StateObject private var viewModel = CollectionViewModel()
    
    /// Corpo da `CollectionView`, responsável por construir a interface de usuário.
    var body: some View {
        NavigationView {
            VStack {
                // Barra de pesquisa para filtrar as cartas na coleção
                HStack {
                    TextField(NSLocalizedString("Search Cards", comment: ""), text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }
                
                // Lista que exibe os itens da coleção filtrados pela pesquisa
                List {
                    ForEach(viewModel.filteredItems) { item in
                        // Link de navegação para a visualização detalhada da carta selecionada
                        NavigationLink(destination: CardDetailView(
                            card: Card(id: item.cardId, name: item.name, typeLine: item.type_Line, imageUris: Card.ImageURIs(
                                small: item.imageUrl, normal: item.imageUrl, large: item.imageUrl, png: "", artCrop: "", borderCrop: ""), oracleText: ""
                            ),
                            addCardToCollection: { _ in },
                            hideAddButton: true
                        )) {
                            HStack {
                                // Imagem da carta
                                if let url = URL(string: item.imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 60)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 60, height: 60)
                                    }
                                } else {
                                    // Placeholder se a imagem não estiver disponível
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                // Informações da carta (nome e tipo)
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("\(item.type_Line)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.leading, 8)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    // Função para deletar itens da coleção
                    .onDelete { indexSet in
                        viewModel.deleteItems(at: indexSet, context: modelContext)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle(NSLocalizedString("My Collection", comment: ""))
                .toolbar {
                    EditButton()
                }
            }
            .onAppear {
                // Carrega os itens ao aparecer a view
                viewModel.loadItems(from: items)
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}
