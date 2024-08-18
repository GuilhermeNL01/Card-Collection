//
//  ScryfallAPI.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation

class ScryfallAPI {
    private let baseURL = "https://api.scryfall.com/cards/search"
    
    func searchCards(query: String, completion: @escaping ([Card]?) -> Void) {
        let urlString = "\(baseURL)?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Request Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received from API")
                completion(nil)
                return
            }
            
            if let rawString = String(data: data, encoding: .utf8) {
                print("Raw API Response: \(rawString)")
            }
            
            do {
                let response = try JSONDecoder().decode(ScryfallResponse.self, from: data)
                if response.data.isEmpty {
                    print("No cards found for the query")
                    completion(nil)
                } else {
                    completion(response.data)
                }
            } catch {
                print("Error decoding API response: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
