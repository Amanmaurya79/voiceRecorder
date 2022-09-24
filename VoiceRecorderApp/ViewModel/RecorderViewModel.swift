//
//  AudioRecorder.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import Foundation
import SwiftUI
import CoreData


class RecorderViewModel: ObservableObject {
    private var audioRecorderService: AudioRecorderService = AudioRecorderService()
//    private var coreDataServices: CoreDataServices = CoreDataServices()
    private var audioPlayerService: AudioPlayerServices = AudioPlayerServices()
    private let manager = CoreDataManager()
    
    @Published private(set) var recordings: [Recording] = []
    @Published private(set) var folders: [Folder] = []
    @Published var isRecording = false
    @Published var isPlaying = false
    
    init() {
        fetchRequestFolder()
        fetchRequestRecording()
    }
    
    func startRecording() {
        audioRecorderService.startRecording()
        DispatchQueue.main.async {
            self.isRecording = true
        }
    }
    
    func stopRecording(folder: Folder) {
        audioRecorderService.stopRecording()
        DispatchQueue.main.async {
            self.isRecording = false
            self.saveRecordingOnCoreData(folder: folder)
            self.fetchRequestRecording()
        }
    }
    
    func startPlayback(recording: Recording) {
        audioPlayerService.startPlayback(recording: recording)
        DispatchQueue.main.async {
            self.isPlaying = true
        }
    }
    
    func stopPlayback() {
        audioPlayerService.stopPlayback()
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
// MARK: core Data
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
            folders =  try manager.container.viewContext.fetch(request)
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
  
    func saveRecordingOnCoreData(folder: Folder) {
        let newRecording = Recording(context:  manager.container.viewContext)
        newRecording.fileURL = audioRecorderService.recordingData
        newRecording.createdAt = Date()
        folder.addToFolderToRecording(newRecording)
        
        manager.save()
            print("Stop Recording - Successfully saved to CoreData")
            // delete the recording stored in the temporary directory
        audioRecorderService.deleteRecordingFile()
    }
    
    
  func deleteFolder(indexSet: IndexSet) {
      guard let index = indexSet.first else { return }
      let entityOffolder = folders[index]
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
