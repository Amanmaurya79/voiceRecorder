//
//  CoreDataServices.swift
//  VoiceRecorderApp
//
//  Created by Aman on 03/11/22.
//

import Foundation
import CoreData

protocol RecordingServiceProtocol {
    var persistentContainer: NSPersistentContainer { get }
    func save()
    func fetchRequestRecording() -> [Recording]
    func fetchRequestFolder() -> [Folder]
    func addNewFolder(name: String)
    func saveRecordingOnCoreData(folder: Folder, audioRecorderServices: AudioRecorderService)
    func deleteFolder(entityOffolder: Folder)
    func deleteRecording(entityOfRecording: Recording)
}


class CoreDataServices: RecordingServiceProtocol {
    
    enum StorageType {
        case persistent, inMemory
    }
    
    let persistentContainer: NSPersistentContainer
    init(_ storageType: StorageType = .persistent) {
        persistentContainer = NSPersistentContainer(name: "RecordingModel")
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("\(error)")
            }
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func fetchRequestRecording() -> [Recording] {
        var recordings: [Recording] = []
        let request = NSFetchRequest<Recording>(entityName: "Recording")
        do {
            recordings =  try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching \(error)")
        }
        return recordings
    }
    
    func fetchRequestFolder() -> [Folder] {
        var folders: [Folder] = []
        let request = NSFetchRequest<Folder>(entityName: "Folder")
        do {
            folders =  try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching \(error)")
        }
        return folders
    }
    
    func addNewFolder(name: String) {
        let folder = Folder(context: persistentContainer.viewContext)
        folder.name = name
        folder.date = Date()
        save()
    }
    
    func saveRecordingOnCoreData(folder: Folder, audioRecorderServices: AudioRecorderService) {
        let newRecording = Recording(context:  persistentContainer.viewContext)
        newRecording.fileURL = audioRecorderServices.recordingData
        newRecording.createdAt = Date()
        folder.addToFolderToRecording(newRecording)
        save()
    }
    
    func deleteFolder(entityOffolder: Folder) {
        persistentContainer.viewContext.delete(entityOffolder)
        save()
    }
    
    func deleteRecording(entityOfRecording: Recording) {
        persistentContainer.viewContext.delete(entityOfRecording)
        save()
    }
    
}
