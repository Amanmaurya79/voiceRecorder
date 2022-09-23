//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct RecordingListView: View {
    var folder: Folder
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        List {
            if let methods = folder.folderToRecording?.allObjects as? [Recording] {
                ForEach(methods, id: \.id) { method in
                    if let fileURL = method.fileURL {
                        Text("\(fileURL)")
                    }
            }
        }
//            .onDelete(perform: recorderViewModel.deleteRecording(indexSet:))
        }.navigationTitle("All Recording")
    }

}


struct RecordingRow: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var recording: Recording
    @State var audioIsPlaying: Bool = false
    var body: some View {
        HStack {
            VStack {
                Text("\(recording)")
                    .font(.callout)
            }
            Spacer()
            Button(action: {
                audioIsPlaying.toggle()
                recorderViewModel.isPlaying ?  recorderViewModel.stopPlayback() : recorderViewModel.startPlayback(recording: recording)
            }) {
                Image(systemName: audioIsPlaying ? "stop.fill" : "play.circle"  )
                    .imageScale(.large)
            }
        }
    }
}

//struct RecordingListView_Previews: PreviewProvider {
//    @StateObject static var recorderViewModel: RecorderViewModel = RecorderViewModel()
//    static var previews: some View {
//        RecordingListView(recorderViewModel: recorderViewModel)
//    }
//}
