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
        self.theme = GreenTheme()
    }
}


private struct SettingThemeKey: EnvironmentKey {
    static let defaultValue: SettingTheme = GreenTheme()
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
    var themeColor: Color { get }
    var fontColor: Color { get }
    var accentColor: Color { get }
}


protocol SettingFont {
    var sanserif: String { get }
    var serif: String { get }
}

struct GreenTheme: SettingTheme {
    var themeColor: Color {
        Color("themeGreen")
    }
    
    var accentColor: Color {
        Color("accentGreen")
    }
    
    var fontColor: Color {
        Color("fontGreen")
    }
}
struct BeigeTheme: SettingTheme {
    var themeColor: Color {
        Color("themeBeige")
    }
    
    var accentColor: Color {
        Color("accentBeige")
    }
    
    var fontColor: Color {
        Color("fontBeige")
    }
}

struct BlueTheme: SettingTheme {
    var themeColor: Color {
        Color("themeBlue")
    }
    
    var accentColor: Color {
        Color("accentBlue")
    }
    
    var fontColor: Color {
        Color("fontBlue")
    }
}

struct BasicFont: SettingFont {
    var sanserif: String {
        "BlackHanSans-Regular"
    }
    var serif: String {
        "SongMyung-Regular"
    }
    
}

struct CursiveFont: SettingFont {
    var sanserif: String {
        "NanumBrushScript-Regular"
    }
    var serif: String {
        "NanumPenScript-Regular"
    }

}
struct HandFont: SettingFont {
    var sanserif: String {
        "NotoSansKR-Regular"
    }
    var serif: String {
        "CuteFont-Regular"
    }
    
}
