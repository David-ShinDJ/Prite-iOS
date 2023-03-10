//
//  CoreLocation.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/14.
//

import Foundation
import MapKit
import CoreLocation



class CoreLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var region = MKCoordinateRegion(center: Constants.defaultLocation, span: Constants.mapMagnitude)
    
    func setMagnitude(latitudeDelta: Double, longitudeDelta: Double) {
        var newRegion = self.region
        newRegion.span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        self.region = newRegion
    }
    
    var locationManager: CLLocationManager?

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
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
            self.region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? Constants.defaultLocation, span: Constants.mapMagnitude)
            locationManager.stopUpdatingLocation()
        default:
            break
        }
    }
    
    // MARK: CLLocationManager 객체생성전 checkLocationAuthorization 실행하라는데 불가능한 버그같음 CLLocationManager.authorizationStatus() ios14 deprecated 됐음
    func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
        } else {
        print("외부환경 또는 기기의 문제가 발생하여 위치정보를 확인할수 없습니다")
        }
    }
    
}
