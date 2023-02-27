//
//  OnboardingView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
// TODO: 온보딩뷰 끝내기
let description: [String] = [
    "설명문구~~~~~~~~~~~~~~~~~~~~~~~~",
    "설명문구~!!!!!!!!!!!",
    "설명문구~~~@@@@@@@@@~~~~~~~",
    "설명문구~~~@@@@@@@########"
]
struct OnboardingContent: View {
    @Binding var onboardingSheet:Bool
    @Binding var onboadringNumber:Int
    var body: some View {
        VStack {
            Text("Place + Write = Prite")
                .font(.title)
            Image("trip\(onboadringNumber)")
                    .resizable()
                    .frame(width:.infinity, height:200)
            Text(description[onboadringNumber])
                .font(.title2)
            Spacer()
        }
    }
}
struct OnboardingButton: View {
    @Binding var onboardingNumber:Int
    @State private var animate = true
    var body: some View {
        GeometryReader { proxy in
            LazyHStack(spacing:proxy.size.width / 2.5) {
                Button(action: {
                    withAnimation {
                        onboardingNumber -= 1
                    }
                }) {
                    Text("이전⬅️")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title.bold().lowercaseSmallCaps())
                    .opacity(animate ? 0.5 : 1.0)
                    .animation(Animation.easeOut(duration: 2.0).repeatForever(), value: animate)
                    .onAppear {
                        self.animate = true
                    }
                }
                Button(action: {
                    withAnimation {
                        onboardingNumber += 1
                    }
                }) {
                    Text("다음➡️")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 15)
                    .font(Font.title.bold().lowercaseSmallCaps())
                    .opacity(animate ? 0.5 : 1.0)
                    .animation(Animation.easeOut(duration: 2.0).repeatForever(), value: animate)
                    .onAppear {
                        self.animate = true
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .position(x:proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}
struct OnboardingView: View {
    @Binding var onboardingSheet:Bool
    @State private var onboardingNumber:Int = 0
    @State private var animate = false
    private func upOnboardingNumber() {
        if onboardingNumber < 2 {
            self.onboardingNumber += 1
        }
    }
    private func downOnboardingNumber() {
        if onboardingNumber > 0 {
            self.onboardingNumber -= 1
        }
    }
    var body: some View {
        ZStack {
            OnboardingContent(onboardingSheet: $onboardingSheet, onboadringNumber: $onboardingNumber)
            OnboardingButton(onboardingNumber: $onboardingNumber).opacity(1.2)
            OnboardingSkipButton(onboardingSheet: $onboardingSheet)
        }
    }
}
struct OnboardingSkipButton: View {
    
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
