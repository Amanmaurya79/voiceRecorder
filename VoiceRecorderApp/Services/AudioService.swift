//
//  AudioService.swift
//  VoiceRecorderApp
//
//  Created by Aman on 13/09/22.
//

import Foundation
import AVFoundation


class AudioPlayerServices: NSObject, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer!
    
    func startPlayback(audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing over the device's speakers failed")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
        } catch {
            print("Playback failed.")
        }
        
    }
    
    func stopPlayback() {
        audioPlayer.stop()
    }
}

