//
//  ContentView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var audioRecorder: AudioRecorder = AudioRecorder()
    @State var textSearch: String
    var body: some View {
        VStack {
            SearchBar(textSearch: $textSearch)
            ListViewFile(audioRecorder: audioRecorder)
            Spacer()
            Button(action: {
                audioRecorder.recording ? audioRecorder.stopRecording() : audioRecorder.startRecording()
            }) {
                Image(systemName: audioRecorder.recording ? "stop.fill" : "circle.fill" )
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

struct ContentView_Previews: PreviewProvider {
    @StateObject static var audioRecorder: AudioRecorder = AudioRecorder()
    static var previews: some View {
        NavigationView {
            ListViewFile(audioRecorder: audioRecorder)
        }
    }
}
