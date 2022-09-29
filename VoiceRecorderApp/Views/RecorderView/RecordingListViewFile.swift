//
//  ListViewfile.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct RecordingListView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var folder: Folder
    var body: some View {
        List {
            if let recordings = folder.folderToRecording?.allObjects as? [Recording] {
                ForEach(recordings.sorted(by: {$0.createdAt ?? Date() < $1.createdAt ?? Date()}), id: \.self) { record in
                    if let createdAt = record.createdAt {
                        RecordingRow(recorderViewModel: recorderViewModel, record: record, createdAt: createdAt)
                    }
                }
                .onDelete(perform: recorderViewModel.deleteRecording(indexSet:))
            }
            
        }.listStyle(InsetGroupedListStyle())
        
    }
}

struct RecordingRow: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    @State var isAudioPlayerPresented: Bool = false
    var record: Recording
    var createdAt: Date
    var body: some View {
        HStack {
            VStack {
                Text("\(createdAt)")
                    .padding(.vertical, 5)
            }
            Button {
                isAudioPlayerPresented.toggle()
            } label: {
                Image(systemName: "play.circle")
                    .imageScale(.large)
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isAudioPlayerPresented, content: {
                AudioPlayerView(recorderViewModel: recorderViewModel
                                , record: record)
            })
        }
    }
}


//struct RecordingListView_Previews: PreviewProvider {
//    @StateObject static var recorderViewModel: RecorderViewModel = RecorderViewModel()
//    static var previews: some View {
//        RecordingListView(recorderViewModel: recorderViewModel)
//    }
//}
