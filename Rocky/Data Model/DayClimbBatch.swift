//
//  DayClimbBatch.swift
//  Rocky
//
//  Created by Russell Blickhan on 12/14/22.
//

import Foundation
import SwiftUI

struct DayClimbBatch: Identifiable {
    var climbs: [Climb]
    let timestamp: Date
    let id = UUID()

    var successfulClimbs: [Climb] {
        climbs.filter(\.successful)
    }

    var unsuccessfulClimbs: [Climb] {
        climbs.filter { !$0.successful }
    }

    var successRate: Float {
        Float(successfulClimbs.count) / Float(successfulClimbs.count + unsuccessfulClimbs.count)
    }
}

extension FetchedResults<Climb> {
    var batched: [DayClimbBatch] {
        reduce(into: []) { partialResult, nextClimb in
            let nextClimbTimestamp = nextClimb.timestamp ?? Date()
            let climbBatchTimestamp = partialResult.last?.climbs.first?.timestamp ?? Date()
            if partialResult.isEmpty || !Calendar.current.isDate(nextClimbTimestamp, inSameDayAs: climbBatchTimestamp) {
                // Start a new batch
                partialResult.append(DayClimbBatch(climbs: [nextClimb], timestamp: nextClimbTimestamp))
            } else {
                // Append to the existing batch
                partialResult[partialResult.count - 1].climbs.append(nextClimb)
            }
        }
    }
}
