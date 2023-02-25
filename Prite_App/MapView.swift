//
//  HomeView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.

import Foundation
import SwiftUI
import MapKit


struct MapView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @ObservedObject var proxyDatabase: ProxyDatabase
    @State var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.42898, longitude: 127.09638), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems:proxyDatabase.models) {
                    data in MapAnnotation(coordinate: data.coordinate) {
                        NavigationLink {
                            DetailView(mapModel: data)
                        } label: {
                            Circle()
                                .stroke(Color(.red), lineWidth: 3)
                                .frame(width: 48 , height: 48)
                        }
                    }
                }
                Button {
                    print(proxyDatabase.latitude, proxyDatabase.longitude)
                    proxyDatabase.setMyLocation()
                } label: {
                    Text("MapMagnitude Check")
                        .font(.custom(font.titleFont, size: font.titleSize))
                }

            }
            .navigationBarHidden(true)
            .navigationTitle("맵화면")
            .onAppear {
                self.region = proxyDatabase.coreLocation.region
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var proxyDatabase:ProxyDatabase = ProxyDatabase()
    static var previews: some View {
        MapView(proxyDatabase: proxyDatabase)

    }
}
