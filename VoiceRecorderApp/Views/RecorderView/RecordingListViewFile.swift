//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct RecordingListView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        List {
            ForEach(recorderViewModel.recordings, id: \.createdAt) { recording in
                RecordingRow( recorderViewModel: recorderViewModel, recording: recording)
            }
            .onDelete(perform: recorderViewModel.deleteRecording(indexSet:))
        }
    }

}


struct RecordingRow: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var recording: Recording
    @State var audioIsPlaying: Bool = false
    var body: some View {
        HStack {
            VStack {
                if let createdAt = recording.createdAt {
                    Text((createdAt),style: .date)
                        .font(.callout)
                }
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

struct RecordingListView_Previews: PreviewProvider {
    @StateObject static var recorderViewModel: RecorderViewModel = RecorderViewModel()
    static var previews: some View {
        RecordingListView(recorderViewModel: recorderViewModel)
    }
}
