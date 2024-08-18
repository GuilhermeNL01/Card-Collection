//
//  Card.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation

struct Card: Identifiable, Codable {
    let id: String
    let name: String
    let typeLine: String
    let imageUris: ImageURIs
    let oracleText: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case typeLine = "type_line"
        case imageUris = "image_uris"
        case oracleText = "oracle_text"
    }
    
    struct ImageURIs: Codable {
        let small: String
        let normal: String
        let large: String
        let png: String
        let artCrop: String
        let borderCrop: String
        
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
