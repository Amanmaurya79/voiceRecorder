//
//  VoiceRecorderAppApp.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

@main
struct VoiceRecorderAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RecorderView()
                    .preferredColorScheme(.dark)
            }.navigationTitle("All Recordings")
        }
    }
}
