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
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Write.date, ascending: false)],
                  animation: .default)
    private var writes: FetchedResults<Write>
  
    //MARK : Published Data 업데이트되서 Publishing changes from within view updates is not allowed, this will cause undefined behavior. 발생함
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems:writes) {
                    write in MapAnnotation(coordinate:CLLocationCoordinate2D(latitude: write.latitude, longitude: write.longitude)) {
                        NavigationLink {
                            DetailView(write: write)
                        } label: {
                            Circle()
                                .stroke(theme.accentColor, lineWidth: 3)
                                .frame(width: 48, height: 48)
                        }
                    }
                }
                Button {
                    self.region = self.coreLocationManager.region
                    print(writes)
                } label: {
                    Label("위치재확인", systemImage: "arrow.clockwise")
                        .foregroundColor(theme.accentColor)
                }
                QuoteView(length: "short")
                    .font(.custom(font.serif, size: 18))
                    .padding()
                
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

