//
//  Persistence.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import CoreData

struct PersistenceController {
    
    static let shared: PersistenceController = {
        let instace = PersistenceController()
        return instace
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PriteDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/Users/david/Local/Prite_App")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error)  in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
