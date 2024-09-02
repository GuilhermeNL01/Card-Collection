//
//  Card.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation

/// `Card` é uma estrutura que representa um cartão em uma coleção de cartas. Esta estrutura é conformante com `Identifiable` e `Codable`.
struct Card: Identifiable, Codable {
    
    /// Identificador único do cartão.
    let id: String
    
    /// Nome do cartão.
    let name: String
    
    /// Linha do tipo do cartão, que descreve o tipo de carta (ex: "Creature - Elf").
    let typeLine: String
    
    /// URLs das diferentes versões da imagem do cartão.
    let imageUris: ImageURIs
    
    /// Texto oracular do cartão, que descreve suas habilidades e efeitos no jogo.
    let oracleText: String
    
    /// Enum que mapeia as chaves JSON para as propriedades da estrutura `Card`.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case typeLine = "type_line"
        case imageUris = "image_uris"
        case oracleText = "oracle_text"
    }
    
    /// `ImageURIs` é uma estrutura aninhada que contém URLs para diferentes tamanhos e cortes da imagem do cartão.
    struct ImageURIs: Codable {
        
        /// URL para a imagem pequena do cartão.
        let small: String
        
        /// URL para a imagem normal do cartão.
        let normal: String
        
        /// URL para a imagem grande do cartão.
        let large: String
        
        /// URL para a versão PNG da imagem do cartão.
        let png: String
        
        /// URL para a versão cortada artisticamente da imagem do cartão.
        let artCrop: String
        
        /// URL para a versão cortada da borda da imagem do cartão.
        let borderCrop: String
        
        /// Enum que mapeia as chaves JSON para as propriedades da estrutura `ImageURIs`.
        enum CodingKeys: String, CodingKey {
            case small
            case normal
            case large
            case png
            case artCrop = "art_crop"
            case borderCrop = "border_crop"
        }
    }
}
