//
//  AudioService.swift
//  VoiceRecorderApp
//
//  Created by Aman on 13/09/22.
//

import Foundation
import AVFoundation


class AudioPlayerServices: NSObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    var recordingDuration: Double?
    var recordingCurrentTime: Double?
    
    func startPlayback(recording: Recording) {
        if let recordingData = recording.fileURL {
            let playbackSession = AVAudioSession.sharedInstance()
            
            do {
                try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
            } catch {
                print("Playing over the device's speakers failed")
            }
            
            do {
                audioPlayer = try AVAudioPlayer(data: recordingData)
                audioPlayer?.delegate = self
                recordingDuration = audioPlayer?.duration
                recordingCurrentTime = audioPlayer?.currentTime
            } catch {
                print("Playback failed.")
            }
        } else {
            print("Play Recording - Could not get the recording data")
        }
        
    }
  
    func stopPlayback() {
        audioPlayer?.stop()
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.stop()
    }
    
}

