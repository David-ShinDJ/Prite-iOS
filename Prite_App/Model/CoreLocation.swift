//
//  CoreLocation.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/14.
//

import Foundation
import MapKit
import CoreLocation

let defaultLocation = CLLocationCoordinate2D(latitude: 37.5511, longitude: 126.9882)
let mapMagnitude = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)

class CoreLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: defaultLocation, span: mapMagnitude)
    
    func setMagnitude(latitudeDelta: Double, longitudeDelta: Double) {
        self.region.span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }
    
    func getCoordinate() -> CLLocationCoordinate2D {
        self.region.center
        
    }
    
    
    var locationManager: CLLocationManager?
    // MARK: Location 탐지하는동안 MainThread 탐지되는동안 UI멈추는 이슈 존재함
    func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        } else {
            print("외부환경 또는 기기의 문제가 발생하여 위치정보를 확인할수 없습니다")
        }
    }

    
    // MARK: 프린트문말고 오류메시지 문구를 확인할수있는 Alert구현
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("사용자는 현재 접근금지 위치지역에 위치해있습니다.")
        case .denied:
            print("사용자의 위치정보 사용을 거부당했습니다")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? defaultLocation, span: mapMagnitude)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
