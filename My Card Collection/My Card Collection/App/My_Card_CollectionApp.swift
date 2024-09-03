//
//  My_Card_CollectionApp.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 17/08/24.
//

import SwiftUI
import SwiftData

@main
struct My_Card_CollectionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CollectionItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.unselected
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label(NSLocalizedString("Search", comment: ""), systemImage:"magnifyingglass")
                    }
                CollectionView()
                    .tabItem {
                        Label(NSLocalizedString("Collection", comment: ""), systemImage: "menucard")
                    }
                InfoView()
                    .tabItem {
                        Label(NSLocalizedString("Info", comment: ""),systemImage: "info.circle.fill")
                    }
            }
            .accentColor(.accent)
            .modelContainer(sharedModelContainer)
        }
    }
}
