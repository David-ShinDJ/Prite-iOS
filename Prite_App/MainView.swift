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
    @ObservedObject var settingEnvironment: SettingEnvironment = SettingEnvironment()
    @StateObject var coreLocationManager: CoreLocationManager = CoreLocationManager()
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @State private var introduction: String = "작성한 글목록을 보여줍니다"
    
    let persistenceController = PersistenceController.shared
    var body: some View {
        VStack {
            Text(introduction)
                .font(.custom(font.titleFont, size: 24))
            TabView(selection:$introduction){
                ListView()
                    .tag("작성한 글목록을 보여줍니다")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Writing", systemImage: "list.clipboard")
                    }
                WriteView(coreLocationManager: coreLocationManager)
                    .tag("내가 있는곳의 사진을찍고 \n 글쓰기를 작성해보세요")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Write", systemImage: "highlighter")
                }
                MapView(coreLocationManager: coreLocationManager)
                    .tag("내가 작성한 글의 위치에 따라 지도에 표시됩니다")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Label("Map", systemImage: "location.fill")
                }
                SettingView(settingEnvironment: settingEnvironment, coreLocationManager: coreLocationManager)
                    .tag("폰트&테마를 변경할수있습니다")
                    .environment(\.environmentTheme, settingEnvironment.theme)
                    .environment(\.environmentFont, settingEnvironment.font)
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                    }
            }.accentColor(theme.buttonColor)
        }.onAppear {
            coreLocationManager.checkLocation()
        }
    }
}


