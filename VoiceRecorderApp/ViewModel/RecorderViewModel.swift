//
//  AudioRecorder.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import Foundation
import CoreData

class RecorderViewModel: ObservableObject {
    private var audioRecorderService: AudioRecorderService = AudioRecorderService()
    private(set) var audioPlayerService: AudioPlayerServices = AudioPlayerServices()
    private var coreDataServices: CoreDataServices = CoreDataServices()
    
    @Published private(set) var recordings: [Recording] = []
    @Published private(set) var folders: [Folder] = []
    @Published var isRecording = false
    @Published var recordingDuration = 0.0
    @Published var recordingCurrentTime = 0.0
    @Published var currentlyPlaying: Recording?
    
    init() {
        self.folders = self.coreDataServices.fetchRequestFolder()
        self.recordings = self.coreDataServices.fetchRequestRecording()
    }
    
    //    MARK: Recording -
    
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
            self.currentlyPlaying = recording
            self.recordingDuration = self.audioPlayerService.recordingDuration ?? 0.0
            self.recordingCurrentTime = self.audioPlayerService.recordingCurrentTime ?? 0.0
        }
    }
    
    
    func stopPlayback() {
        audioPlayerService.stopPlayback()
        DispatchQueue.main.async {
            self.currentlyPlaying = nil
        }
    }
    
    func play() {
        DispatchQueue.main.async {
            self.audioPlayerService.play()
        }
    }
    
    func pause() {
        DispatchQueue.main.async {
            self.audioPlayerService.pause()
        }
    }
    
    
    // MARK: core Data
  
    func fetchRequestRecording()  {
        DispatchQueue.main.async {
            self.recordings = self.coreDataServices.fetchRequestRecording()
        }
    }
    
    func fetchRequestFolder() {
        DispatchQueue.main.async {
            self.folders = self.coreDataServices.fetchRequestFolder()
        }
    }
    
    func addNewFolder(name: String) {
        DispatchQueue.main.async {
            self.coreDataServices.addNewFolder(name: name)
            self.folders = self.coreDataServices.fetchRequestFolder()
        }
    }
    
    func saveRecordingOnCoreData(folder: Folder) {
        DispatchQueue.main.async {
            self.coreDataServices.saveRecordingOnCoreData(folder: folder, audioRecorderServices: self.audioRecorderService)
        }
        // delete the recording stored in the temporary directory
        audioRecorderService.deleteRecordingFile()
    }
    
    
    func deleteFolder(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entityOffolder = folders[index]
        DispatchQueue.main.async {
            self.coreDataServices.deleteFolder(entityOffolder: entityOffolder)
            self.folders = self.coreDataServices.fetchRequestFolder()
        }
    }
    
    func deleteRecording(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entityOfRecording = recordings[index]
        DispatchQueue.main.async {
            self.coreDataServices.deleteRecording(entityOfRecording: entityOfRecording)
            self.recordings = self.coreDataServices.fetchRequestRecording()
        }
    }
}
