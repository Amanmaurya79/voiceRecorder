//
//  CoreDataServices.swift
//  VoiceRecorderApp
//
//  Created by Aman on 22/09/22.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataServices {
    let manager = CoreDataManager()

    var folder: [Folder] = []
    var recordings: [Recording] = []
      
    init () {
        fetchRequestFolder()
        fetchRequestRecording()
    }
      func saveData() {
          manager.save()
          fetchRequestFolder()
          fetchRequestRecording()
      }
      
      func fetchRequestRecording()  {
          let request = NSFetchRequest<Recording>(entityName: "Recording")
          do {
              recordings =  try manager.container.viewContext.fetch(request)
          } catch let error {
              print("Error Fetching \(error)")
          }
      }
      
      func fetchRequestFolder() {
          let request = NSFetchRequest<Folder>(entityName: "Folder")
          do {
              folder =  try manager.container.viewContext.fetch(request)
          } catch let error {
              print("Error Fetching \(error)")
          }
      }
      
      func addNewFolder(name: String) {
          let folder = Folder(context: manager.container.viewContext)
          folder.name = name
          folder.date = Date()
          saveData()
      }
    
    func deleteFolder(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entityOffolder = folder[index]
        manager.container.viewContext.delete(entityOffolder)
        saveData()
    }
    
    func deleteRecording(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entityOfRecording = recordings[index]
        manager.container.viewContext.delete(entityOfRecording)
        saveData()
    }
}
