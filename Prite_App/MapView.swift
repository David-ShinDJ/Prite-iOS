//
//  HomeView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.

import Foundation
import SwiftUI
import MapKit

// TODO: View 구성 다시 짜기, 위치 재확인 버튼추가
struct MapView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @StateObject var coreLocationManager: CoreLocationManager
    @State var region:MKCoordinateRegion = MKCoordinateRegion(center: Constants.defaultLocation, span: Constants.mapMagnitude)
    var models:[WriteModel] = [
                WriteModel(title:"모란시장", plot:"모란시장에서...", image:UIImage(named: "model0")!,latitude: 37.42917,longitude: 127.12710),
               WriteModel(title:"탄천입구", plot:"탄천입구에서...", image:UIImage(named: "model1")!,latitude: 37.42768, longitude: 127.11720),
               WriteModel(title:"서울공항", plot:"서울공항에서...", image:UIImage(named: "model2")!,latitude: 37.44609, longitude: 127.11147),
               WriteModel(title:"신구대식물원", plot:"신구대식물원에서...", image:UIImage(named: "model3")!,latitude: 37.43395, longitude: 127.08085),
               WriteModel(title:"청계산", plot:"청계산에서...", image:UIImage(named: "model4")!,latitude: 37.44826, longitude: 127.05469),
               WriteModel(title:"코이카", plot:"코이카에서...", image:UIImage(named: "model5")!,latitude: 37.41629, longitude: 127.09754),
               WriteModel(title:"차병원", plot:"차병원에서...", image:UIImage(named: "model6")!,latitude: 37.41027, longitude: 127.09754),
               WriteModel(title:"성남시청", plot:"성남시청에서...", image:UIImage(named: "model7")!,latitude: 37.42002, longitude: 127.12665)
    ]
    
    //MARK : Published Data 업데이트되서 Publishing changes from within view updates is not allowed, this will cause undefined behavior. 발생함
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems:models) {
                    data in MapAnnotation(coordinate: data.coordinate) {
                        NavigationLink {
//                            DetailView(model:model)
                        } label: {
                            Circle()
                                .stroke(theme.iconColor, lineWidth: 3)
                                .frame(width: 48 , height: 48)
                                
                        }
                    }
                }
                QuoteView(length: "short")
                    .font(.custom(font.titleFont, size: 18))
                Button {
                    self.region = coreLocationManager.region
                } label: {
                    Text("위치재확인")
                        .font(.custom(font.titleFont, size: 18))
                }
                
            }
            .onAppear {
                self.coreLocationManager.checkLocation()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        self.region = self.coreLocationManager.region
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("맵화면")
        }
    }
}

