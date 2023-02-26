//
//  MainView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
// MARK @StateObject 공유하는경우 두개의뷰에서 서로다른 작업이 일어나면 Published 오류발생함
// TODO: introduction 문구 수정하기
struct MainView: View {
    @StateObject var settingEnvironment: SettingEnvironment = SettingEnvironment()
    @StateObject var proxyDatabase:ProxyDatabase = ProxyDatabase()
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @State private var introduction: String = "List"
    var body: some View {
        VStack {
            Text(introduction)
            TabView(selection:$introduction){
                ListView(proxyDatabase: proxyDatabase)
                    .tag("List")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Writing", systemImage: "list.clipboard")
                    }
                WriteView(proxyDatabase:proxyDatabase)
                    .tag("Write")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Write", systemImage: "highlighter")
                }
                MapView(proxyDatabase: proxyDatabase)
                    .tag("Map")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Map", systemImage: "location.fill")
                }
                SettingView()
                    .tag("Setting")
                    .environmentObject(settingEnvironment)
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                    }
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
