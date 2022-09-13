//
//  VoiceRecorderAppApp.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

@main
struct VoiceRecorderAppApp: App {
    @StateObject var audioRecorder: AudioRecorder = AudioRecorder()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(audioRecorder: audioRecorder, textSearch: "")
                    .preferredColorScheme(.dark)
            }.navigationTitle("All Recordings")
        }
    }
}
