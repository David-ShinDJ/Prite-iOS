//
//  OnboardingView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
let description: [String] = [
    "👋 안녕하세요 플라이트입니다 \n 살짝 갑작스럽지만 \n 이 앱을 만든 배경을 알려드리고싶습니다.",
    "📝 우리는 생각보다 \n 글쓰기라는 창작활동에 대해서 \n 많은 어려움을 느끼고있습니다",
    "📒 그래서 언제 어디서나 \n 글쓰기를 쉽게 시작할수있게 \n 글을 쓸수있는 앱이 있다면 좋다고 생각했습니다",
    "🧭 플라이트를 통해 \n 글쓰기하여 리스트로 저장하고 지도에 표시된 심볼을 통해서도 \n 내 글을 확인해볼수있습니다"
]

struct OnboardingContent: View {
    @Binding var onboardingSheet:Bool
    @Binding var onboardingNumber:Int
    var body: some View {
        VStack(alignment:.center, spacing: 40) {
            Image("onboarding\(onboardingNumber)")
                .resizable()
                .frame(maxHeight:400)
                .ignoresSafeArea()
            Text(description[onboardingNumber])
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
struct OnboardingButton: View {
    @State private var animate = false
    @Binding var onboardingNumber:Int
    @Binding var onboardingSheet:Bool
    @AppStorage("Onboarding") private var onboarding: Bool = true
    var body: some View {
        GeometryReader { proxy in
            LazyHStack(spacing:proxy.size.width / 2)  {
                Button {
                    withAnimation {
                        if self.onboardingNumber >= 1 {
                            self.onboardingNumber -= 1
                        }
                    }
                } label: {
                    Text("⏪️ 이전")
                        .font(.largeTitle)
                        .opacity(animate ? 0.2 : 0.8)
                        .animation(Animation.easeOut(duration: 2.0).repeatForever(), value: animate)
                        .onAppear {
                            self.animate = true
                        }
                }.opacity(self.onboardingNumber == 0 ? 0.0 : 1.0)
                Button {
                    withAnimation {
                        if self.onboardingNumber <= 2 {
                            self.onboardingNumber += 1
                        } else if self.onboardingNumber == 3 {
                            onboardingSheet = false
                            onboarding = onboardingSheet
                        }
                    }
                } label: {
                    Text(self.onboardingNumber == 3 ? "시작🏚️" : "다음 ⏩️")
                        .font(.largeTitle)
                        .opacity(animate ? 0.2 : 0.8)
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
    var body: some View {
            ZStack {
                OnboardingContent(onboardingSheet: $onboardingSheet, onboardingNumber: $onboardingNumber)
                OnboardingButton(onboardingNumber: $onboardingNumber, onboardingSheet: $onboardingSheet)
                OnboardingSkipButton(onboardingSheet: $onboardingSheet)
        }
    }
}
struct OnboardingSkipButton: View {

    @AppStorage("Onboarding") private var onboarding: Bool = true
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
                .background(Color.blue)
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
