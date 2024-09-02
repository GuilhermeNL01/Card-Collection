//
//  SearchViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import Combine
import SwiftUI

/**
 `SearchBarViewModel` é uma classe simples que gerencia o estado do texto em uma barra de pesquisa no aplicativo "My Card Collection". Ela implementa o protocolo `ObservableObject`, permitindo que a interface do usuário observe e reaja a mudanças na propriedade publicada.

 ## Propriedades:
 - `text`: Uma string que armazena o texto digitado pelo usuário na barra de pesquisa.

 ## Métodos:
 - `clearText()`: Limpa o texto na barra de pesquisa, definindo a string como vazia.

 ## Uso:
 Este ViewModel é utilizado para controlar o texto da barra de pesquisa e fornecer uma função para limpar esse texto. Ele pode ser ligado diretamente a uma `TextField` em SwiftUI para atualização em tempo real.
 */
class SearchBarViewModel: ObservableObject {
    @Published var text: String = ""
    
    /**
     Limpa o texto da barra de pesquisa, definindo-o como uma string vazia.
     */
    func clearText() {
        text = ""
    }
}
