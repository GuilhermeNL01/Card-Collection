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
    
    /// URL base para as pesquisas de cartas na API Scryfall.
    private let baseURL = "https://api.scryfall.com/cards/search"
    
    /// Realiza uma busca na API Scryfall utilizando uma consulta fornecida.
    ///
    /// - Parameters:
    ///   - query: A string que representa a consulta de busca (ex: nome da carta, tipo, etc.).
    ///   - completion: Um closure que será chamado com o resultado da busca,
    ///     retornando um array opcional de objetos `Card`. Se ocorrer um erro ou
    ///     nenhuma carta for encontrada, `completion` será chamado com `nil`.
    ///
    /// - Example:
    ///  ```swift
    /// let api = ScryfallAPI()
    /// api.searchCards(query: "lightning bolt") { cards in
    ///     if let cards = cards {
    ///         print("Cartas encontradas: \(cards)")
    ///     } else {
    ///         print("Nenhuma carta encontrada ou ocorreu um erro.")
    ///     }
    /// }
    /// 
    func searchCards(query: String, completion: @escaping ([Card]?) -> Void) {
        // Codifica a query para ser usada na URL.
        let urlString = "\(baseURL)?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        // Verifica se a URL é válida.
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }
        
        // Cria uma tarefa para realizar a requisição HTTP GET.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Verifica se houve um erro na requisição.
            if let error = error {
                print("API Request Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Verifica se há dados na resposta.
            guard let data = data else {
                print("No data received from API")
                completion(nil)
                return
            }
            
            do {
                // Tenta decodificar os dados recebidos em um objeto `ScryfallResponse`.
                let response = try JSONDecoder().decode(ScryfallResponse.self, from: data)
                
                // Verifica se o array de cartas está vazio.
                if response.data.isEmpty {
                    print("No cards found for the query: \(query)")
                    completion(nil)
                } else {
                    completion(response.data)
                }
            } catch {
                // Lida com erros de decodificação.
                print("Error decoding API response: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        // Inicia a tarefa de requisição à API.
        task.resume()
    }
}
