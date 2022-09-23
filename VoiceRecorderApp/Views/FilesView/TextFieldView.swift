//
//  FolderView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 23/09/22.
//

import SwiftUI

struct TextFieldView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    @State private var folderName: String = ""
    var body: some View {
        VStack{
            TextField("enter your folder name", text: $folderName)
            HStack {
                Button {
                    
                } label: {
                    Text("cancel")
                }
                
                Button {
                    recorderViewModel.createFolder(name: folderName)
                } label: {
                    Text("save")
                }

            }
        }
    }
}

//struct FolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FolderView()
//    }
//}
