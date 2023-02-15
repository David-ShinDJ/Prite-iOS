//
//  OnboardingView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @Binding var onboardingSheet:Bool
    var body: some View {
            ZStack {
                OnboardingFirst(onboardingSheet: $onboardingSheet)
                Spacer()
                OnboardingButton(onboardingSheet: $onboardingSheet)
        }
    }
}

struct OnboardingButton: View {
    
    // #1
    @AppStorage("Onboarding") private var onboarding: Bool = false
    @Binding var onboardingSheet:Bool
    
    var body: some View {
        GeometryReader { proxy in
            LazyHStack {
                Button(action: {
                    onboardingSheet = false
                    onboarding = onboardingSheet
                }) {
                    Text("앱에 대한 설명 건너뛰기 🖐️")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title2.bold().lowercaseSmallCaps())
                }
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(40)
                .frame(minWidth: 0, maxWidth: proxy.size.width-40)
            }
            .frame(width: proxy.size.width, height: proxy.size.height / 5)
            .position(x:proxy.size.width / 2, y: proxy.size.height - 50)
        }
    }
}





struct Previews_OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingSheet: .constant(true))
    }
}
