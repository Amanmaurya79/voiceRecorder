//
//  AudioPlayerView.swift
//  VoiceRecorderApp
//
//  Created by Aman on 11/09/22.
//

import SwiftUI

import SwiftUI


struct AudioPlayerView: View {
    @State private var expanded: Bool = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "backward.fill")
                Image(systemName: "play.fill")
                Image(systemName: "forward.fill")
            }.foregroundColor(.white)
                .font(.title)
            
        }.frame(maxWidth: .infinity, maxHeight: expanded ? 200: 60)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                    expanded.toggle()
                }
            }
            .background {
                Color.black
            }
            .clipShape(RoundedRectangle(cornerRadius: 40.0, style: .continuous))
            .padding()
    }
}

struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView()
    }
}
