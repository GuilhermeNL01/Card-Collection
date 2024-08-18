//
//  FontManager.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

struct FontManager {
    // Enum para tamanhos de fonte personalizados
    enum FontSize: CGFloat {
        case largeTitle = 34
        case title = 28
        case title2 = 22
        case title3 = 20
        case headline = 17
        case body = 16
        case callout = 15
        case subheadline = 14
        case footnote = 13
        case caption = 12
        case caption2 = 11
    }
    
    // Função para obter a fonte personalizada com um tamanho específico
    static func planewalker(size: FontSize) -> Font {
        return .custom("Planewalker", size: size.rawValue)
    }
    
    // Função para obter a fonte personalizada com um tamanho customizado
    static func planewalker(size: CGFloat) -> Font {
        return .custom("Planewalker", size: size)
    }
}
