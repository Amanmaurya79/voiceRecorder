//
//  DateStringExtension.swift
//  VoiceRecorderApp
//
//  Created by Aman on 08/09/22.
//

import Foundation
extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
