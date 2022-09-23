//
//  AudioRecorder.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import Foundation
import SwiftUI


class RecorderViewModel: ObservableObject {
    private var audioRecorderService: AudioRecorderService = AudioRecorderService()
    private var coreDataServices: CoreDataServices = CoreDataServices()
    private var audioPlayerService: AudioPlayerServices = AudioPlayerServices()
    
    @Published private(set) var recordings: [Recording] = []
    @Published private(set) var folders: [Folder] = []
    @Published var isRecording = false
    @Published var isPlaying = false
    
    init() {
        DispatchQueue.main.async {
            self.recordings = self.coreDataServices.recordings
            self.folders = self.coreDataServices.folder
        }
    }
    
    func startRecording() {
        audioRecorderService.startRecording()
        DispatchQueue.main.async {
            self.isRecording = true
        }
    }
    
    func stopRecording() {
        audioRecorderService.stopRecording()
        DispatchQueue.main.async {
            self.recordings = self.coreDataServices.recordings
            self.isRecording = false
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
    
    func deleteRecording(indexSet: IndexSet) {
        coreDataServices.deleteRecording(indexSet: indexSet)
        DispatchQueue.main.async {
            self.recordings = self.coreDataServices.recordings
        }
    }
    
    func createFolder(name: String) {
        coreDataServices.addNewFolder(name: name)
        DispatchQueue.main.async {
            self.folders = self.coreDataServices.folder
        }
    }
    
    func deleteFolder(index: IndexSet) {
        coreDataServices.deleteFolder(indexSet: index)
        DispatchQueue.main.async {
            self.folders = self.coreDataServices.folder
        }
    }
    
    
}
