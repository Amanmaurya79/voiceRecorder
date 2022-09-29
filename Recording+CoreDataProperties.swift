//
//  Recording+CoreDataProperties.swift
//  VoiceRecorderApp
//
//  Created by Aman on 28/09/22.
//
//

import Foundation
import CoreData


extension Recording {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recording> {
        return NSFetchRequest<Recording>(entityName: "Recording")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var fileURL: Data?
    @NSManaged public var recordingToFolder: Folder?

}

extension Recording : Identifiable {

}
