//
//  Folder+CoreDataProperties.swift
//  VoiceRecorderApp
//
//  Created by Aman on 23/09/22.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var folderToRecording: NSSet?

}

// MARK: Generated accessors for folderToRecording
extension Folder {

    @objc(addFolderToRecordingObject:)
    @NSManaged public func addToFolderToRecording(_ value: Recording)

    @objc(removeFolderToRecordingObject:)
    @NSManaged public func removeFromFolderToRecording(_ value: Recording)

    @objc(addFolderToRecording:)
    @NSManaged public func addToFolderToRecording(_ values: NSSet)

    @objc(removeFolderToRecording:)
    @NSManaged public func removeFromFolderToRecording(_ values: NSSet)

}

extension Folder : Identifiable {

}
