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
    
    var title: String
    var plot: String
    var date: Date
    var image: UIImage
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(title: String, plot: String, date: Date, image: UIImage, latitude: Double, longitude: Double) {
        self.title = title
        self.plot = plot
        self.date = date
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
