//
//  CollectionItem.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation
import SwiftData

@Model
final class CollectionItem {
    var cardId: String
    var name: String
    var imageUrl: String

    init(cardId: String, name: String, imageUrl: String) {
        self.cardId = cardId
        self.name = name
        self.imageUrl = imageUrl
    }
}
