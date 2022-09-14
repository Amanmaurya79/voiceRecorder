//
//  VoiceRecorderAppApp.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

@main
struct VoiceRecorderAppApp: App {
    @StateObject var recorderViewModel: RecorderViewModel = RecorderViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RecorderView(recorderViewModel: recorderViewModel, textSearch: "")
                    .preferredColorScheme(.dark)
            }.navigationTitle("All Recordings")
        }
    }
}
