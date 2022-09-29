//
//  AudioRecorderSerrvice.swift
//  VoiceRecorderApp
//
//  Created by Aman on 14/09/22.
//

import Foundation
import AVFoundation

class AudioRecorderService {
    var audioRecorder: AVAudioRecorder!
    var recordingDate: Date?
    var recordingData: Data?
    var recordingName: String = ""
    var recordingURL: URL?
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        let currentDateTime = Date.now
        recordingDate = currentDateTime
        recordingName = "\(currentDateTime.toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss"))"
        
        // save the recording to the temporary directory
        let tempDirectory = FileManager.default.temporaryDirectory
        let recordingFileURL = tempDirectory.appendingPathComponent(recordingName).appendingPathExtension("m4a")
        recordingURL = recordingFileURL
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: recordingFileURL, settings: settings)
            audioRecorder.record()
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        audioRecorder.stop()
        if let recordingURL = recordingURL {
            do {
                recordingData = try Data(contentsOf: recordingURL)
                print("Stop Recording - Saving to CoreData")
            } catch {
                print("Stop Recording - Could not save to CoreData - Cannot get the recording data from URL: \(error)")
            }
        } else {
            print("Stop Recording -  Could not save to CoreData - Cannot find the recording URL")
        }
    }
    
    func deleteRecordingFile() {
        if let recordingURL =  recordingURL {
            do {
                try FileManager.default.removeItem(at: recordingURL)
                print("Stop Recording - Successfully deleted the recording file")
            } catch {
                print("Stop Recording - Could not delete the recording file - Cannot find the recording URL")
            }
        }
    }
}
