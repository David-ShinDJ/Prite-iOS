//
//  SettingEnvironment.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/23.
//

import Foundation
import SwiftUI

final class SettingEnvironment: ObservableObject {

    @Published var theme:SettingTheme
    @Published var font:SettingFont

    init() {
        self.font = BasicFont()
        self.theme = BasicTheme()
    }
    
}


private struct SettingThemeKey: EnvironmentKey {
    static let defaultValue: SettingTheme = BasicTheme()
}
private struct SettingFontKey: EnvironmentKey {
    static let defaultValue:SettingFont = BasicFont()
    
}
extension EnvironmentValues {
    var environmentTheme: SettingTheme {
        get { self[SettingThemeKey.self]}
        set { self[SettingThemeKey.self] = newValue}
    }
    var environmentFont: SettingFont {
        get { self[SettingFontKey.self]}
        set { self[SettingFontKey.self] = newValue}
    }
}

extension View {
    func customThemeValue(_ themeValue: SettingTheme) -> some View {
        environment(\.environmentTheme, themeValue)
    }
    
    func customFontValue(_ fontValue: SettingFont) -> some View {
        environment(\.environmentFont, fontValue)
    }
}

protocol SettingTheme {
    var buttonColor: Color { get }
    var fontColor: Color { get }
    var iconColor: Color { get }
}


protocol SettingFont {
    var titleFont: String { get }
    var plotFont: String { get }
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

struct BasicFont: SettingFont {
    var titleFont: String {
        "BlackHanSans-Regular"
    }
    var plotFont: String {
        "SongMyung-Regular"
    }
    
}

struct EliteFont: SettingFont {
    var titleFont: String {
        "NanumPenScript-Regular"
    }
    var plotFont: String {
        "Dongle-Regular"
    }

}
struct CuteFont: SettingFont {
    var titleFont: String {
        "Gaegu-Regular"
    }
    var plotFont: String {
        "CuteFont-Regular"
    }
    
}
