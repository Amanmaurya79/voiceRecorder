//
//  VoiceRecorderAppTests.swift
//  VoiceRecorderAppTests
//
//  Created by Aman on 26/09/22.
//

import XCTest
import CoreData
@testable import VoiceRecorderApp


final class CoreDataTest: XCTestCase {

    var testStorage: RecordingServiceProtocol!
    
    override func setUpWithError() throws {
        testStorage = CoreDataServices(.inMemory)
    }

    override func tearDownWithError() throws {
        testStorage = nil
    }

    func recordingIsNilForFirstTime() {
         let context = testStorage.persistentContainer.viewContext
         let allRecordingItems = try! context.fetch(Recording.fetchRequest())
         
         XCTAssertEqual([], allRecordingItems)
         XCTAssertEqual(0, allRecordingItems.count)
     }

    func recordingSavingIsValid() {
     
    }
    
    func recordingDeleteIsValid() {
        
    }

}
