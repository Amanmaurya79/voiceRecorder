//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct ListViewFile: View {
    @StateObject var recordingFetcher: RecordingFetcher = RecordingFetcher()
    
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
    var audioURL: URL
    var isCheck: Bool = false
//    @State var isSheetPresented = false
    @ObservedObject var audioPlayer = AudioPlayer()
    var body: some View {
        HStack {
            VStack {
                Text("\(audioURL.lastPathComponent)")
                    .font(.callout)
            }
            Spacer()
            if audioPlayer.isPlaying == false {
                Button {
//                    isSheetPresented.toggle()
                    audioPlayer.startPlayback(audio: audioURL)
                } label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
//                .sheet(isPresented: $isSheetPresented) {
//                    AudioPlayerView()
//                }
            } else {
                Button {
                    audioPlayer.stopPlayback()
                } label: {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
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
