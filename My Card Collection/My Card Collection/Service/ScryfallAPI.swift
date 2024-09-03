//
//  ScryfallAPI.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation

/// `ScryfallAPI` é uma classe responsável por interagir com a API do Scryfall
/// para buscar cartas de Magic: The Gathering com base em uma consulta fornecida.
class ScryfallAPI {
    private let baseURL = "https://api.scryfall.com/cards/search"
    
    /// Busca cartas com base na consulta fornecida e no modo de unicidade.
    /// - Parameters:
    ///   - query: A consulta de pesquisa para buscar as cartas.
    ///   - unique: O modo de unicidade para a consulta (por exemplo, "art" ou "prints").
    ///   - page: O número da página para paginar os resultados.
    ///   - completion: A closure a ser chamada quando a resposta da API for recebida.
    func searchCards(query: String, unique: String? = nil, page: Int = 1, completion: @escaping ([Card]?) -> Void) {
        var urlString = "\(baseURL)?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&page=\(page)"
        
        if let unique = unique {
            urlString += "&unique=\(unique)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
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
            
            do {
                let response = try JSONDecoder().decode(ScryfallResponse.self, from: data)
                if response.data.isEmpty {
                    print("No cards found for the query: \(query)")
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
