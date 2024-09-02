//
//  ScryfallResponse.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import Foundation

/**
 `ScryfallResponse` é uma estrutura que representa a resposta da API Scryfall para uma busca de cartas. Ela é usada para decodificar a resposta JSON da API em um formato que pode ser facilmente manipulado no aplicativo.

 ## Propriedades:
 - `data`: Um array de `Card` que contém as cartas retornadas pela pesquisa na API Scryfall.

 ## Conformidade:
 - `Codable`: Conformidade com o protocolo `Codable` permite que a estrutura seja facilmente codificada e decodificada de/para JSON.

 ## Detalhes:
 - A propriedade `data` é uma lista de objetos `Card`, que são as cartas resultantes da pesquisa feita através da API.

 ## Exemplo de Uso:
 Esta estrutura é tipicamente usada para decodificar a resposta JSON da API Scryfall no `ScryfallAPI`. A resposta JSON da API contém uma chave `data` que mapeia para um array de objetos `Card`.

 ## Exemplo de Decodificação:
 ```swift
 let response = try JSONDecoder().decode(ScryfallResponse.self, from: data)
 let cards = response.data */
struct ScryfallResponse: Codable {
let data: [Card]
}
