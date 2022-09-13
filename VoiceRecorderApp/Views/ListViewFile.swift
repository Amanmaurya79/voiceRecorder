//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct ListViewFile: View {
    @ObservedObject var recordingFetcher: RecordingFetcher = RecordingFetcher()
    var body: some View {
        List {
            ForEach(recordingFetcher.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }.navigationTitle("All Recording")
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(recordingFetcher.recordings[index].fileURL)
        }
        recordingFetcher.deleteRecording(urlsToDelete: urlsToDelete)
    }
    
}


struct RecordingRow: View {
    @StateObject var audioPlayer = AudioPlayer()
    var audioURL: URL
    var body: some View {
        HStack {
            VStack {
                Text("\(audioURL.lastPathComponent)")
                    .font(.callout)
            }
            Spacer()
            Button(action: {
                audioPlayer.isPlaying ?  audioPlayer.stopPlayback() : audioPlayer.startPlayback(audio: audioURL)
            }) {
                Image(systemName: audioPlayer.isPlaying ? "stop.fill" : "play.circle"  )
                    .imageScale(.large)
            }
        }
    }
}

struct ListViewFile_Previews: PreviewProvider {
    @ObservedObject static var recorder: RecordingFetcher = RecordingFetcher() 
    static var previews: some View {
        ListViewFile(recordingFetcher: recorder)
    }
}
