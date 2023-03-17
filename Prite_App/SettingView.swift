//
//  SettingView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

struct SettingView:View {
    enum FontStyle: String, CaseIterable, Identifiable {
        case basic, cursive, hand
        var id: Self { self }
    }

    enum ThemeStyle: String, CaseIterable, Identifiable {
        case green, beige, blue
        var id: Self { self }
    }
    
    @ObservedObject var settingEnvironment: SettingEnvironment
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @State private var fontValue: FontStyle = .basic
    @State private var themeValue: ThemeStyle = .green
    @AppStorage("Font") static private var savedFont:String = "basic"
    @AppStorage("Theme") static private var savedTheme:String = "green"
    
    var body: some View {
        VStack (alignment: .center){
            Form {
                Section (header:Text("폰트변경")) {
                    Picker("폰트", selection: $fontValue) {
                        Text("기본").tag(FontStyle.basic)
                        Text("흘림").tag(FontStyle.cursive)
                        Text("손글씨").tag(FontStyle.hand)
                    }
                    .font(.custom(font.serif, size: 22))
                }.onChange(of: fontValue) { newValue in
                    if fontValue == .basic {
                        settingEnvironment.font = BasicFont()
                        SettingView.savedFont = "basic"
         
                    } else if fontValue == .cursive {
                        settingEnvironment.font = CursiveFont()
                        SettingView.savedFont = "cursive"
                     
                    } else {
                        settingEnvironment.font = HandFont()
                        SettingView.savedFont = "hand"
            
                    }
                }
                Section (header:Text("테마변경")){
                    Picker("테마", selection: $themeValue) {
                        Text("올리브그린").tag(ThemeStyle.green)
                        Text("베이지").tag(ThemeStyle.beige)
                        Text("라이트블루").tag(ThemeStyle.blue)
                    }
                    .font(.custom(font.serif, size: 22))
                    .onChange(of: themeValue) { newValue in
                        if themeValue == .green {
                            settingEnvironment.theme = GreenTheme()
                        
                        } else if themeValue == .beige {
                            settingEnvironment.theme = BeigeTheme()
                  
                        } else {
                            settingEnvironment.theme = BlueTheme()
        
                        }
                    }
                }
            }
            Text("앱제작 : DavidShin \n 앱버전 : 1.0.0 ")
                .font(.custom(font.serif, size: 18))
                .padding()
        }.onAppear {
            if SettingView.savedFont == "cursive" {
                self.fontValue = .cursive
            } else if SettingView.savedFont == "hand" {
                self.fontValue = .hand
            }
            
        }
    }
}

