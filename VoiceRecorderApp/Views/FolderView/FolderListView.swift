//
//  FolderListView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 23/09/22.
//

import SwiftUI

struct FolderListView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        List {
            ForEach(recorderViewModel.folders, id: \.self) { folder in
                NavigationLink(folder.name ?? "Recording" ) {
                    RecorderView(recorderViewModel: recorderViewModel, folder: folder)
                }
            }
            .onDelete(perform: recorderViewModel.deleteFolder(indexSet:))
        }
    }
}

//struct FileListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderListView()
//    }
//}
