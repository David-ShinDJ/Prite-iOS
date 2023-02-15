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
    
    @State private var selectedFont: FontStyle = .basic
    @State private var mapMagnitude: Double = 0.5
    @State private var darkMode:Bool = false
    
    var body: some View {
        VStack{
            Form {
                Section (header:Text("폰트변경")){
                    Picker("폰트", selection: $selectedFont) {
                            Text("기본").tag(FontStyle.basic)
                            Text("고급").tag(FontStyle.elite)
                            Text("귀여운").tag(FontStyle.cute)
                        }
                }
                Section (header: Text("지도크기변경")) {
                    Slider(value: $mapMagnitude)
                }
                Section (header: Text("배경색")) {
                    
                    Toggle(isOn: $darkMode) {
                        Text("어둡게")
                    }
                }
            }
            
            Text("앱제작자 및 버전소개")
                .padding()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
