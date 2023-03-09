//
//  WriteModel.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import Foundation
import UIKit
import CoreLocation

class WriteModel: Identifiable {
    let title:String?
    let plot:String?
    let image: UIImage?
    let latitude: Double?
    let longitude: Double?
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude ?? 37.42898, longitude: longitude ?? 127.09638)
    }
    init(title: String, plot: String, image: UIImage, latitude: Double, longitude: Double) {
        self.title = title
        self.plot = plot
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
}
