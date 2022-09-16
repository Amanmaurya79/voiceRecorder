//
//  ContentView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct RecorderView: View {
    @StateObject var recorderViewModel: RecorderViewModel = RecorderViewModel()
    @State var textSearch: String = ""
    var body: some View {
        VStack {
            SearchBar(textSearch: $textSearch)
            ListViewFile(recorderViewModel: recorderViewModel)
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


struct SearchBar: View {
    @Binding var textSearch: String
    var body: some View {
        HStack {
             Image(systemName: "magnifyingglass")
            TextField("Search ...", text: $textSearch).foregroundColor(.white)
         }.padding(.leading, 13)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ListViewFile()
//        }
//    }
//}
