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
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    var body: some View {
        TabView {
            MapView()
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Map", systemImage: "location.fill")
            }
            WriteView()
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Write", systemImage: "highlighter")
                    
            }
            ListView()
                .environment(\.environmentTheme, settingEnvironment.theme)
                .environment(\.environmentFont, settingEnvironment.font)
                .tabItem {
                    Label("Writing", systemImage: "list.clipboard")
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
    static var previews: some View {
        MainView()
    }
}
