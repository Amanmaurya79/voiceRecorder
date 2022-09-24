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
            if let recordings = folder.folderToRecording?.allObjects as? [Recording] {
                ForEach(recordings.sorted(by: {$0.createdAt ?? Date() < $1.createdAt ?? Date()}), id: \.id) { record in
                    if let createdAt = record.createdAt {
                        Text("\(createdAt)")
                            .padding(.vertical, 5)
                    }
                    //                        .onDelete(perform: recorderViewModel.deleteRecording(indexSet:))
                }
            }
            
        }.listStyle(InsetGroupedListStyle())
        
    }
}

struct RecordingRow: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var folder: Folder
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


//struct RecordingListView_Previews: PreviewProvider {
//    @StateObject static var recorderViewModel: RecorderViewModel = RecorderViewModel()
//    static var previews: some View {
//        RecordingListView(recorderViewModel: recorderViewModel)
//    }
//}
