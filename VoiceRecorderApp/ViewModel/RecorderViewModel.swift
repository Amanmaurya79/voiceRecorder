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
   private var fileService: FileServices = FileServices()
   private var audioPlayerService: AudioPlayerServices = AudioPlayerServices()
    
    @Published private(set) var recordings: [Recording] = []
    @Published var isRecording = false
    @Published var isPlaying = false
    
    init() {
        DispatchQueue.main.async {
            self.recordings = self.fileService.fetchRecordings()
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
            self.recordings = self.fileService.fetchRecordings()
            self.isRecording = false
        }
    }
    
    func startPlayback(audio: URL) {
        audioPlayerService.startPlayback(audio: audio)
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
    
    func deleteRecording(urlsToDelete: [URL]) {
        fileService.deleteRecording(urlsToDelete: urlsToDelete)
        DispatchQueue.main.async {
            self.recordings = self.fileService.fetchRecordings()
        }
    }
}
