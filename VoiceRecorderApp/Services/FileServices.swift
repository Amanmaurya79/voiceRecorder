//
//  AudioRecorderServices.swift
//  VoiceRecorderApp
//
//  Created by Aman on 13/09/22.
//

import Foundation

//class FileServices {
//    need to create a static var for file manager
    
//    func fetchRecordings() -> [Recording] {
//        var recordings: [Recording] = []
//        let fileManager = FileManager.default
//        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
//        for audio in directoryContents {
//            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
//                recordings.append(recording)
//        }
//        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
//        return recordings
//    }
    
//}
