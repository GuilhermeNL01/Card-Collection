//
//  InfoView.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // App Title
                Text("Cards Dungeon")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                // App Overview
                Text("Welcome to Cards Dungeon! This app was created to help you manage your card collection in a practical and efficient way. With it, you can easily view, add, and organize your cards. Our goal is to provide an intuitive and useful experience to keep your collection always in order.")
                    .font(.body)
                    .padding(.bottom)
                
                Divider() // Divider between sections
                
                // Contact Information
                VStack(alignment: .leading, spacing: 16) {
                    Text("Contact Us:")
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
                
                Divider() // Divider between sections
                
                // Privacy Policy
                VStack(alignment: .leading, spacing: 16) {
                    Text("Privacy Policy:")
                        .font(.headline)
                    
                    Link("Read our Privacy Policy", destination: URL(string: "https://your-privacy-policy-url.com")!)
                        .font(.body)
                        .foregroundColor(.accentColor)
                }
                .padding(.bottom)
                
                Divider() // Divider between sections
                
                // Disclaimer and Copyright
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disclaimer:")
                        .font(.headline)
                    
                    Text("This app is an independent project and is not officially affiliated with Wizards of the Coast. All rights to the names and images of the cards belong to their respective owners.")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        }
        .navigationBarTitle("About", displayMode: .inline)
    }
}

#Preview {
    InfoView()
        .previewLayout(.sizeThatFits)
        .padding()
}
