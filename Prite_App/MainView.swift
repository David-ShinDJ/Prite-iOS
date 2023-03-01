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
    @State private var introduction: String = "작성한 글목록을 보여줍니다"
    var body: some View {
        VStack {
            Text(introduction)
            TabView(selection:$introduction){
                ListView(proxyDatabase: proxyDatabase)
                    .tag("작성한 글목록을 보여줍니다")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Writing", systemImage: "list.clipboard")
                    }
                WriteView(proxyDatabase:proxyDatabase)
                    .tag("현재위치한곳에 사진을 찍은뒤 글을 작성해보세요")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Write", systemImage: "highlighter")
                }
                MapView(proxyDatabase: proxyDatabase)
                    .tag("내가작성한 글의 위치에 따라 지도에 표시됩니다")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Map", systemImage: "location.fill")
                }
                SettingView()
                    .tag("폰트&테마&지도크기를 변경할수있습니다")
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
