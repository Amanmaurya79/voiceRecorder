//
//  CoreDataMager.swift
//  VoiceRecorderApp
//
//  Created by Aman on 22/09/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let managerInstance: CoreDataManager = CoreDataManager()
    let container: NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "RecordingModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
