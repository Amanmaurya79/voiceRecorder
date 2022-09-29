//
//  AudioPlayerView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 11/09/22.
//

import SwiftUI

struct AudioPlayerView: View {
    @ObservedObject var recorderViewModel: RecorderViewModel
    @State var sliderValue: Double = 0.0
    @State private var isDragging = false
    @State private var isPlaying = false
    var record: Recording
    let timer = Timer
        .publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
    var body: some View {
        VStack {
            Slider(value: $sliderValue,  in: 0...(recorderViewModel.audioPlayerService.audioPlayer?.duration ?? 0.0 )) { dragging in
                print("Editing the slider: \(dragging)")
                isDragging = dragging
                if !dragging {
                    recorderViewModel.audioPlayerService.audioPlayer?.currentTime = sliderValue
                    print("\(sliderValue)")
                }
            }.tint(.primary)
                .padding()
            
            // Time passed & Time remaining
            HStack {
                Text(DateComponentsFormatter.positional.string(from: recorderViewModel.audioPlayerService.audioPlayer?.currentTime ?? 0.0) ?? "0.0" )
                Spacer()
                Text("-\(DateComponentsFormatter.positional.string(from: (recorderViewModel.recordingDuration - recorderViewModel.recordingCurrentTime) ) ?? "0.0" )")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            HStack {
                Button(action: {
                    isPlaying.toggle()
                    isPlaying ?  recorderViewModel.play() : recorderViewModel.pause()
                }) {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill"  )
                        .imageScale(.large)
                }
            }
            if let createdAt = record.createdAt {
                Text("\(createdAt)")
                    .fontWeight(.semibold)
                    .lineLimit(1)
            }
        }
        .onAppear {
            sliderValue = 0
            recorderViewModel.startPlayback(recording: record)
        }
        .onReceive(timer) { _ in
            guard let player = recorderViewModel.audioPlayerService.audioPlayer, !isDragging else { return }
            sliderValue = player.currentTime
        }
        Divider()
    }
}

//struct AudioPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AudioPlayerView()
//    }
//}
