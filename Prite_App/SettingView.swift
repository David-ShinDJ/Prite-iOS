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
    
    @ObservedObject var settingEnvironment: SettingEnvironment
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @State private var fontValue: FontStyle = .basic
    @State private var themeValue: ThemeStyle = .basic
    
    var body: some View {
        VStack (alignment: .center){
            Form {
                Section (header:Text("폰트변경")){
                    Picker("폰트", selection: $fontValue) {
                        Text("기본").tag(FontStyle.basic)
                        Text("고급").tag(FontStyle.elite)
                        Text("귀여운").tag(FontStyle.cute)
                        }
                }.onChange(of: fontValue) { newValue in
                    if fontValue == .basic {
                        settingEnvironment.font = BasicFont()
                    } else if fontValue == .elite {
                        settingEnvironment.font = EliteFont()
                    } else {
                        settingEnvironment.font = CuteFont()
                    }
                }
                Section (header:Text("테마변경")){
                    Picker("테마", selection: $themeValue) {
                        Text("기본").tag(ThemeStyle.basic)
                        Text("고급").tag(ThemeStyle.elite)
                        Text("귀여운").tag(ThemeStyle.cute)
                    }.onChange(of: themeValue) { newValue in
                        if themeValue == .basic {
                            settingEnvironment.theme = BasicTheme()
                        } else if themeValue == .elite {
                            settingEnvironment.theme = EliteTheme()
                        } else {
                            settingEnvironment.theme = CuteTheme()
                          
                        }
                    }
                }
            }
            Text("앱제작자 및 버전소개")
                .padding()
                .foregroundColor(theme.fontColor)
                .font(.custom(font.titleFont, size: 18))
        }
    }
}

