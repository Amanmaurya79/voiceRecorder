//
//  ContentView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct RecorderView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    var body: some View {
        VStack {
            RecordingListView(recorderViewModel: recorderViewModel)
            Spacer()
            Button(action: {
                recorderViewModel.isRecording ? recorderViewModel.stopRecording() : recorderViewModel.startRecording()
            }) {
                Image(systemName: recorderViewModel.isRecording ? "stop.fill" : "circle.fill" )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipped()
                    .foregroundColor(.red)
                    .padding(.bottom, 40)
            }
        } 
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ListViewFile()
//        }
//    }
//}