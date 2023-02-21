//
//  SettingView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

enum FontStyle: String, CaseIterable, Identifiable {
    case basic, elite, cute
    var id: Self { self }
}

enum ThemeStyle: String, CaseIterable, Identifiable {
    case basic, elite, cute
    var id: Self { self }
}

struct SettingView:View {
    
    @EnvironmentObject var settingEnvironment:SettingEnvironment
    
    @State private var fontValue: FontStyle = .basic
    @State private var themeValue: ThemeStyle = .basic
    @State private var mapMagnitude: Double = 0.5
    
    var body: some View {
        VStack{
            Form {
                Section (header:Text("폰트변경")){
                    Picker("폰트", selection: $settingEnvironment.fontValue) {
                        Text("기본").tag(SettingEnvironment.FontStyle.basic)
                        Text("고급").tag(SettingEnvironment.FontStyle.elite)
                            Text("귀여운").tag(SettingEnvironment.FontStyle.cute)
                        }
                }.onChange(of: settingEnvironment.fontValue) { newValue in
                    print("Font: \(newValue)")
                }
                Section (header:Text("테마변경")){
                    Picker("테마", selection: $settingEnvironment.themeValue) {
                        Text("기본").tag(SettingEnvironment.ThemeStyle.basic)
                        Text("고급").tag(SettingEnvironment.ThemeStyle.elite)
                        Text("귀여운").tag(SettingEnvironment.ThemeStyle.cute)
                    }.onChange(of: settingEnvironment.themeValue) { newValue in
                        print("Theme: \(newValue)")
                    }
                }
                Section (header: Text("지도크기변경")) {
                    Slider(value: $settingEnvironment.mapValue)
                        .onChange(of: settingEnvironment.mapValue) { newValue in
                            print("MapMagnitude: \(newValue)")
                        }
                }
            }
            
            Text("앱제작자 및 버전소개")
                .padding()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var settingEnvironment: SettingEnvironment = SettingEnvironment()
    static var previews: some View {
        SettingView()
            .environmentObject(settingEnvironment)
    }
}
