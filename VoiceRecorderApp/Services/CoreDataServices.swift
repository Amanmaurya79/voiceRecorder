//
//  CoreDataServices.swift
//  VoiceRecorderApp
//
//  Created by Aman on 03/11/22.
//

import Foundation
import CoreData

class CoreDataServices {
    private var manager: CoreDataManager = CoreDataManager.managerInstance
    
    func saveData() {
        manager.save()
    }
    
    func fetchRequestRecording() -> [Recording] {
        var recordings: [Recording] = []
        let request = NSFetchRequest<Recording>(entityName: "Recording")
        do {
            recordings =  try manager.container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching \(error)")
        }
        return recordings
    }
    
    func fetchRequestFolder() -> [Folder] {
        var folders: [Folder] = []
        let request = NSFetchRequest<Folder>(entityName: "Folder")
        do {
            folders =  try manager.container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching \(error)")
        }
        return folders
    }
    
    func addNewFolder(name: String) {
        let folder = Folder(context: manager.container.viewContext)
        folder.name = name
        folder.date = Date()
        saveData()
    }
    
    func saveRecordingOnCoreData(folder: Folder, audioRecorderServices: AudioRecorderService) {
        let newRecording = Recording(context:  manager.container.viewContext)
        newRecording.fileURL = audioRecorderServices.recordingData
        newRecording.createdAt = Date()
        folder.addToFolderToRecording(newRecording)
        saveData()
    }
    
    func deleteFolder(entityOffolder: Folder) {
        manager.container.viewContext.delete(entityOffolder)
        saveData()
    }
    
    func deleteRecording(entityOfRecording: Recording) {
        manager.container.viewContext.delete(entityOfRecording)
        saveData()
    }
    
}
