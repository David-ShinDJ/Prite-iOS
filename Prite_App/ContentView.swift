//
//  ContentView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var onboardingSheet:Bool = false
    @AppStorage("Onboarding") private var onboarding:Bool = true
    
    @StateObject var settingEnvironment:SettingEnvironment = SettingEnvironment()
    
    var body: some View {
        MainView()
            .environmentObject(settingEnvironment)
            .sheet(isPresented: $onboardingSheet) {
                OnboardingView(onboardingSheet: $onboardingSheet)
            }
            .onAppear {
                onboardingSheet = onboarding
            }
    }
}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()

    }
}
