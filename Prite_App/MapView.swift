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
    @ObservedObject var proxyDatabase: ProxyDatabase
    @ObservedObject var locationManager: LocationManager = LocationManager()
    @State var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D()
    init(proxyDatabase: ProxyDatabase, locationManager: LocationManager = LocationManager()) {
        self.proxyDatabase = proxyDatabase
        self.locationManager = locationManager
        locationManager.checkLocation()
    }
    
    var model: Model = Model(image: Image("trip0"), data: Date(), title: "title", plot: "Plot")
    
    //MARK : Published Data 업데이트되서 Publishing changes from within view updates is not allowed, this will cause undefined behavior. 발생함
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems:proxyDatabase.models) {
                    data in MapAnnotation(coordinate: data.coordinate) {
                        NavigationLink {
                            DetailView(model:model)
                        } label: {
                            Circle()
                                .stroke(Color(.red), lineWidth: 3)
                                .frame(width: 48 , height: 48)
                        }
                    }
                }
                QuoteView(length: "short")
                    .font(.custom(font.titleFont, size: 18))
                Button {
                    self.locationManager.checkLocation()
                } label: {
                    Text("위치재확인")
                        .font(.custom(font.titleFont, size: 18))
                }
                

            }
            .navigationBarHidden(true)
            .navigationTitle("맵화면")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(proxyDatabase: ProxyDatabase(),locationManager: LocationManager())

    }
}
