//
//  InfoView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

/// `InfoView` é uma view que exibe informações sobre o aplicativo, como uma visão geral, contato, política de privacidade, e aviso de isenção de responsabilidade.
struct InfoView: View {
    
    /// Corpo da `InfoView`, responsável por construir a interface de usuário.
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Título do aplicativo
                Text("My Card Collection")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // Visão geral do aplicativo
                Text(NSLocalizedString("Welcome to My Card Collection! This app was created to help you manage your card collection in a practical and efficient way. With it, you can easily view, add, and organize your cards. Our goal is to provide an intuitive and useful experience to keep your collection always in order.", comment: ""))
                    .font(.body)
                    .padding(.bottom)
                
                Divider() // Divisor entre seções
                
                // Informações de contato
                VStack(alignment: .leading, spacing: 16) {
                    Text(NSLocalizedString("Contact Us:", comment:""))
                        .font(.headline)
                    
                    HStack {
                        Image("githublogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .accessibilityLabel("GitHub")
                        Link("GuilhermeNL01", destination: URL(string: "https://github.com/GuilhermeNL01")!)
                            .font(.body)
                            .foregroundColor(.accentColor)
                    }
                    
                    HStack {
                        Image(systemName: "envelope")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .accessibilityLabel("Email")
                        Link("cardsdungeon@gmail.com", destination: URL(string: "mailto:cardsdungeon@gmail.com?subject=Cards%20Dungeon")!)
                            .font(.body)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.bottom)
                
                Divider() // Divisor entre seções
                
                // Política de Privacidade
                VStack(alignment: .leading, spacing: 16) {
                    Text(NSLocalizedString("Privacy Policy:", comment: ""))
                        .font(.headline)
                    
                    Link(NSLocalizedString("Read our Privacy Policy", comment: ""), destination: URL(string: "https://sites.google.com/view/cardsdungeon/privacy-policy?authuser=3")!)
                        .font(.body)
                        .foregroundColor(.accentColor)
                }
                .padding(.bottom)
                
                Divider() // Divisor entre seções
                
                // Isenção de responsabilidade
                VStack(alignment: .leading, spacing: 16) {
                    Text(NSLocalizedString("Disclaimer:", comment: ""))
                        .font(.headline)
                    
                    Text(NSLocalizedString("This app is an independent project and is not officially affiliated with Wizards of the Coast. All rights to the names and images of the cards belong to their respective owners.", comment:""))
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer() // Espaçador para alinhar o conteúdo ao topo da tela
            }
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
        .navigationBarTitle(NSLocalizedString("About", comment: ""), displayMode: .inline)
    }
}

#Preview {
    InfoView()
        .previewLayout(.sizeThatFits)
        .padding()
}
