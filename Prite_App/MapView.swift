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
    MapModel(title:"모란시장", plot:"모란시장에서...", image:UIImage(named: "model0")!,latitude: 37.42917,longitude: 127.12710),
    MapModel(title:"탄천입구", plot:"탄천입구에서...", image:UIImage(named: "model1")!,latitude: 37.42768, longitude: 127.11720),
    MapModel(title:"서울공항", plot:"서울공항에서...", image:UIImage(named: "model2")!,latitude: 37.44609, longitude: 127.11147),
    MapModel(title:"신구대식물원", plot:"신구대식물원에서...", image:UIImage(named: "model3")!,latitude: 37.43395, longitude: 127.08085),
    MapModel(title:"청계산", plot:"청계산에서...", image:UIImage(named: "model4")!,latitude: 37.44826, longitude: 127.05469),
    MapModel(title:"코이카", plot:"코이카에서...", image:UIImage(named: "model5")!,latitude: 37.41629, longitude: 127.09754),
    MapModel(title:"차병원", plot:"차병원에서...", image:UIImage(named: "model6")!,latitude: 37.41027, longitude: 127.09754),
    MapModel(title:"성남시청", plot:"성남시청에서...", image:UIImage(named: "model7")!,latitude: 37.42002, longitude: 127.12665),
]


class MapModel: Identifiable {
    let title:String
    let plot:String
    let image: UIImage
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(title: String, plot: String, image: UIImage, latitude: Double, longitude: Double) {
        self.title = title
        self.plot = plot
        self.image = image
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
                        NavigationLink {
                            DetailView(mapModel: data)
                        } label: {
                            Circle()
                                .stroke(Color(.red), lineWidth: 3)
                                .frame(width: 48 , height: 48)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("맵화면")
        }
    }
}

struct MapView_Previews: PreviewProvider {

    static var previews: some View {
        MapView()

    }
}
