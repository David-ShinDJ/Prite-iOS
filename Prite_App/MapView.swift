//
//  HomeView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
// 37.42898 127.09638 우리집 좌표

import Foundation
import SwiftUI
import MapKit

let mapdata = [
    MapModel(latitude: 37.42917, longitude: 127.12710),
    MapModel(latitude: 37.42768, longitude: 127.11720),
    MapModel(latitude: 37.44609, longitude: 127.11147),
    MapModel(latitude: 37.43395, longitude: 127.08085),
    MapModel(latitude: 37.44826, longitude: 127.05469),
    MapModel(latitude: 37.41629, longitude: 127.09754),
    MapModel(latitude: 37.41027, longitude: 127.09754),
    MapModel(latitude: 37.42002, longitude: 127.12665),
]


class MapModel: Identifiable {
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

struct MapView: View {
    @State var region:MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.42898, longitude: 127.09638), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems:mapdata) {
                    data in MapAnnotation(coordinate: data.coordinate) {
                        Circle()
                            .stroke(Color(.red), lineWidth: 3)
                            .frame(width: 48 , height: 48)
                    }
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {

    static var previews: some View {
        MapView()

    }
}
