//
//  Prite_AppApp.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import SwiftUI

@main
struct Prite_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
