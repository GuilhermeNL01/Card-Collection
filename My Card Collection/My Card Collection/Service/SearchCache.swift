//
//  SearchCache.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

class SearchCache {
    private var cache: [String: [Card]] = [:]

    func get(for query: String) -> [Card]? {
        return cache[query]
    }

    func save(_ cards: [Card], for query: String) {
        cache[query] = cards
    }
}
