//
//  OnboardingFirst.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

struct OnboardingFirst: View {
    @Binding var onboardingSheet:Bool
    
    var body: some View {
            NavigationView {
                VStack {
                    Text("나만의 위치에서 글을 작성해보기")
                    Text("글씨기라는 과정은 쉬워보이지만 어렵습니다" + "\n" + "플레이어리는 내가 위치한 곳을 통해 글쓰기를 쉽게 할수있습니다" + "\n" + "나중에 지도를 보고 시간이 흐른뒤에 내가 작성한글을 확인해보세요.")
                    NavigationLink(destination: OnboardingSecond(onboardingSheet: $onboardingSheet).navigationBarBackButtonHidden()) {
                        Text("다음으로")
                    }
                }
            }
    }
}


struct Previews_OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirst(onboardingSheet: .constant(true))
    }
}

struct OnboardingSecond: View {
    @AppStorage("Onboarding") private var onboarding: Bool = false
    @Binding var onboardingSheet:Bool
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    onboardingSheet = false
                    onboarding = onboardingSheet
                } label: {
                    Text("홈으로")
                }

            }
        }
    }
}
