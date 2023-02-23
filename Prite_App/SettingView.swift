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
    
    @EnvironmentObject var themeEnvironment: ThemeEnvironment
    @Environment(\.themeEnvironmentValue) var theme: SettingTheme
    @State private var fontValue: FontStyle = .basic
    @State private var themeValue: ThemeStyle = .basic
    @State private var mapMagnitude: Double = 0.5
    
    var body: some View {
        VStack{
            Form {
                Section (header:Text("폰트변경")){
                    Picker("폰트", selection: $fontValue) {
                        Text("기본").tag(FontStyle.basic)
                        Text("고급").tag(FontStyle.elite)
                        Text("귀여운").tag(FontStyle.cute)
                        }
                }.onChange(of: fontValue) { newValue in
                    print("Font: \(newValue)")
                }
                Section (header:Text("테마변경")){
                    Picker("테마", selection: $themeValue) {
                        Text("기본").tag(ThemeStyle.basic)
                        Text("고급").tag(ThemeStyle.elite)
                        Text("귀여운").tag(ThemeStyle.cute)
                    }.onChange(of: themeValue) { newValue in
                        print("Change")
                        if themeValue == .basic {
                            themeEnvironment.theme = BasicTheme()
                            print("basic")
                        } else if themeValue == .elite {
                            themeEnvironment.theme = EliteTheme()
                            print("elite")
                        } else {
                            themeEnvironment.theme = CuteTheme()
                            print("cute")
                        }
                    }
                }
                Section (header: Text("지도크기변경")) {
                    Slider(value: $mapMagnitude)
                        .onChange(of: mapMagnitude) { newValue in
                            print("MapMagnitude: \(newValue)")
                        }
                }
            }
            SampleView()
                .foregroundColor(theme.buttonColor)
            Text("앱제작자 및 버전소개")
                .padding()
                .foregroundColor(theme.fontColor)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

final class ThemeEnvironment: ObservableObject {
    @Published var theme:SettingTheme
    
    init(theme: SettingTheme = BasicTheme()) {
        self.theme = theme
    }
}
struct SampleView: View {
    var body: some View {
        VStack {
            Text("Hello...")
            Button {
                
            } label: {
                Text("Hello")
            }
            Image(systemName: "house.fill")
        }
    }
}

private struct MySettingThemeKey: EnvironmentKey {
    static let defaultValue: SettingTheme = BasicTheme()
}

extension EnvironmentValues {
    var themeEnvironmentValue: SettingTheme {
        get { self[MySettingThemeKey.self]}
        set { self[MySettingThemeKey.self] = newValue}
    }
}

extension View {
    func myCustomThemeValue(_ myCustomThemeValue: SettingTheme) -> some View {
        environment(\.themeEnvironmentValue, myCustomThemeValue)
    }
}

protocol SettingTheme {
    var buttonColor: Color { get }
    var fontColor: Color { get }
    var iconColor: Color { get }
}

protocol SettingFont {
    var font: String { get }
    var fontSize: Int { get }
}

struct BasicTheme: SettingTheme {
    var buttonColor: Color {
        Color("buttonBasic")
    }
    
    var iconColor: Color {
        Color("iconBasic")
    }
    
    var fontColor: Color {
        Color("fontBasic")
    }
}
struct EliteTheme: SettingTheme {
    var buttonColor: Color {
        Color("buttonElite")
    }
    
    var iconColor: Color {
        Color("iconElite")
    }
    
    var fontColor: Color {
        Color("fontElite")
    }
}

struct CuteTheme: SettingTheme {
    var buttonColor: Color {
        Color("buttonCute")
    }
    
    var iconColor: Color {
        Color("iconCute")
    }
    
    var fontColor: Color {
        Color("fontCute")
    }
}

