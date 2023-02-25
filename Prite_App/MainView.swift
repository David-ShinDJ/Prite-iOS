//
//  MainView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
struct MainView: View {
    @StateObject var settingEnvironment: SettingEnvironment = SettingEnvironment()
    @StateObject var proxyDatabase:ProxyDatabase = ProxyDatabase()
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    var body: some View {
        TabView {
            ListView(proxyDatabase: proxyDatabase)
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Writing", systemImage: "list.clipboard")
                }
            WriteView(proxyDatabase:proxyDatabase)
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Write", systemImage: "highlighter")
            }
            MapView(proxyDatabase: proxyDatabase)
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Map", systemImage: "location.fill")
            }
            SettingView()
                .environmentObject(settingEnvironment)
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Setting", systemImage: "gearshape.fill")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var settingEnvironment: SettingEnvironment = SettingEnvironment()
    static var proxyDatabase:ProxyDatabase = ProxyDatabase()
    static var previews: some View {
        MainView(settingEnvironment: settingEnvironment, proxyDatabase: proxyDatabase)
    }
}
