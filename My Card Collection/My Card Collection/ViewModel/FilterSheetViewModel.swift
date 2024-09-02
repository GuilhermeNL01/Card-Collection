//
//  FilterSheetViewModel.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

/**
 `FilterSheetViewModel` é uma classe que gerencia a lógica para a folha de filtros no aplicativo "My Card Collection". Ela implementa o protocolo `ObservableObject`, permitindo que a interface do usuário observe e reaja a mudanças na propriedade publicada.

 ## Propriedades:
 - `dismiss`: Um ambiente que fornece uma ação para descartar a folha de filtros. Utiliza o ambiente de `SwiftUI` para acessar o método de descarte.

 ## Métodos:
 - `cancel()`: Chama o método `dismiss` para fechar a folha de filtros quando o usuário deseja cancelar a ação.

 ## Uso:
 Este ViewModel é utilizado para gerenciar a interação com a folha de filtros, permitindo que o usuário a feche quando desejar cancelar. Ele utiliza o ambiente de SwiftUI para acessar a funcionalidade de descarte.

 ## Observações:
 - `@Environment(\.dismiss)`: Uma propriedade do ambiente que fornece uma ação para descartar a folha de filtros. É uma forma comum de gerenciar a navegação e o fechamento de modais em SwiftUI.
 */
class FilterSheetViewModel: ObservableObject {
    @Environment(\.dismiss) var dismiss
    
    /**
     Fecha a folha de filtros quando o usuário deseja cancelar a ação.
     */
    func cancel() {
        dismiss()
    }
}
