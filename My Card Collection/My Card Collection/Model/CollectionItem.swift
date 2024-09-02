//
//  CollectionItem.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation
import SwiftData

/// `CollectionItem` é uma classe modelo que representa um item em uma coleção de cartas.
/// Esta classe é marcada com o atributo `@Model` para indicar que ela é gerenciada por SwiftData e persistida no armazenamento de dados.
@Model
final class CollectionItem {
    
    /// Identificador único da carta, associado ao item da coleção.
    var cardId: String
    
    /// Nome da carta associada ao item da coleção.
    var name: String
    
    /// URL da imagem da carta.
    var imageUrl: String
    
    /// Linha do tipo da carta, descrevendo o tipo do cartão (ex: "Creature - Elf").
    var type_Line: String

    /// Inicializador para criar uma nova instância de `CollectionItem` com os valores fornecidos.
    ///
    /// - Parameters:
    ///   - cardId: O identificador único da carta.
    ///   - name: O nome da carta.
    ///   - imageUrl: A URL da imagem da carta.
    ///   - type_Line: A linha do tipo da carta.
    init(cardId: String, name: String, imageUrl: String, type_Line: String) {
        self.cardId = cardId
        self.name = name
        self.imageUrl = imageUrl
        self.type_Line = type_Line
    }
}
