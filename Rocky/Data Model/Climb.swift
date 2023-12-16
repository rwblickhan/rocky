//
//  Climb.swift
//  Rocky
//
//  Created by Russell Blickhan on 12/15/23.
//
//

import Foundation
import SwiftData


@Model
class Climb {
    var grade: Int16 = 0
    var successful: Bool
    var timestamp: Date
    
    init(grade: Int16, successful: Bool, timestamp: Date) {
        self.grade = grade
        self.successful = successful
        self.timestamp = timestamp
    }
    
}
