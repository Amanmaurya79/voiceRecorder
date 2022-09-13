//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct ListViewFile: View {
    @StateObject var audioRecorder: AudioRecorder
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }.navigationTitle("All Recording")
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
    
}


struct RecordingRow: View {
    @ObservedObject var audioRecorder: AudioRecorder = AudioRecorder()
    var audioURL: URL
    var body: some View {
        HStack {
            VStack {
                Text("\(audioURL.lastPathComponent)")
                    .font(.callout)
            }
            Spacer()
            Button(action: {
                audioRecorder.isPlaying ?  audioRecorder.stopPlayback() : audioRecorder.startPlayback(audio: audioURL)
            }) {
                Image(systemName: audioRecorder.isPlaying ? "stop.fill" : "play.circle"  )
                    .imageScale(.large)
            }
        }
    }
}

struct ListViewFile_Previews: PreviewProvider {
    @StateObject static var audioRecorder: AudioRecorder = AudioRecorder()
    static var previews: some View {
        ListViewFile(audioRecorder: audioRecorder)
    }
}
