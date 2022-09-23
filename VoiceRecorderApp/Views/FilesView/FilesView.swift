//
//  FolderListView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 23/09/22.
//

import SwiftUI

struct FilesView: View {
    @StateObject var recorderViewModel: RecorderViewModel = RecorderViewModel()
    @State private var isPresented: Bool = false
    var body: some View {
        VStack {
            FileListView(recorderViewModel: recorderViewModel)
            Spacer()
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "folder.fill.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60 , height: 60)
                    .foregroundColor(.blue)
            }
            .sheet(isPresented: $isPresented, content: {
                TextFieldView(recorderViewModel: recorderViewModel)
            })
            .navigationTitle("All Recording")
        }
    }
}



//struct FolderListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
