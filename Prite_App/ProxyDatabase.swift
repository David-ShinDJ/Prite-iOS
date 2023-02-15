//
//  ProxyDataBase.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/14.
//

import Foundation
import UIKit

class ProxyDatabase: ObservableObject {
    
    let persistanceController: PersistenceController = PersistenceController.shared
    
    @Published var model: WriteModel = WriteModel(title: "", plot: "", date: Date(), image: UIImage(named:"trip0")!, latitude: 37.12345, longitude: 127.12345)
    @Published var models: [WriteModel] = []
    @Published var title:String = ""
    @Published var plot:String = ""
    
    func write(image:UIImage) {
        self.model.title = self.title
        self.model.plot = self.plot
    }
    
    private func createWrite() {
        let newWrite = Write(context:persistanceController.container.viewContext)
        newWrite.title = model.title
        newWrite.plot = model.plot
        newWrite.date = model.date
        newWrite.image = model.image.jpegData(compressionQuality: 0.9)
        newWrite.latitude = model.latitude
        newWrite.longitude = model.longitude
        do {
            try persistanceController.container.viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

