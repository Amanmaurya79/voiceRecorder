//
//  VoiceRecorderAppApp.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

@main
struct VoiceRecorderAppApp: App {
//    @StateObject var recorderViewObject: RecorderViewModel = RecorderViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                FilesView()
                    
                    .preferredColorScheme(.dark)
            }
        }
    }
}
