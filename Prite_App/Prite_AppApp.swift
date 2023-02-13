//
//  Prite_AppApp.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import SwiftUI
import CoreLocation

@main
struct Prite_AppApp: App {
    @StateObject var proxyDatabase:ProxyDatabase = ProxyDatabase()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(proxyDatabase)
        }
    }
}


