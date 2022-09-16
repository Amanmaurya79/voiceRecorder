//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct ListViewFile: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        List {
            ForEach(recorderViewModel.recordings, id: \.createdAt) { recording in
                RecordingRow( recorderViewModel: recorderViewModel, audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }.navigationTitle("All Recording")
    }
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(recorderViewModel.recordings[index].fileURL)
        }
        recorderViewModel.deleteRecording(urlsToDelete: urlsToDelete)
    }
}


struct RecordingRow: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    @State var audioIsPlaying: Bool = false
    var audioURL: URL
    var body: some View {
        HStack {
            VStack {
                Text("\(audioURL.lastPathComponent)")
                    .font(.callout)
            }
            Spacer()
            Button(action: {
                audioIsPlaying.toggle()
                recorderViewModel.isPlaying ?  recorderViewModel.stopPlayback() : recorderViewModel.startPlayback(audio: audioURL)
            }) {
                Image(systemName: audioIsPlaying ? "stop.fill" : "play.circle"  )
                    .imageScale(.large)
            }
        }
    }
}

struct ListViewFile_Previews: PreviewProvider {
    @StateObject static var recorderViewModel: RecorderViewModel = RecorderViewModel()
    static var previews: some View {
        ListViewFile(recorderViewModel: recorderViewModel)
    }
}
