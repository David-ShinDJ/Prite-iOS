//
//  MainView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
struct MainView: View {
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Map", systemImage: "location.fill")
            }
            WriteView()
                .tabItem {
                    Label("Write", systemImage: "highlighter")
            }
            ListView()
                .tabItem {
                    Label("Writing", systemImage: "list.clipboard")
                }
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape.fill")
                }
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
