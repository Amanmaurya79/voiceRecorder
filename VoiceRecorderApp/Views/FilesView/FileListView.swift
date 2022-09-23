//
//  FileListView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 23/09/22.
//

import SwiftUI

struct FileListView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        List {
            ForEach(recorderViewModel.folders, id: \.self) { folder in
                NavigationLink(folder.name ?? "Recording" ) {
                    RecorderView(folder: folder, recorderViewModel: recorderViewModel)
                }
            }
            .onDelete(perform: recorderViewModel.deleteFolder(index:))
        }
    }
}

//struct FileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FileListView()
//    }
//}
