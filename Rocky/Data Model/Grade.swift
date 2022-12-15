//
//  Grade.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import Foundation

enum Grade: Int16, CaseIterable, Identifiable, Codable {
    case vb
    case v0
    case v1
    case v2
    case v3
    case v4
    case v5
    case v6
    case v7
    case v8
    case v9
    case v10

    var displayName: String {
        switch self {
        case .vb: return "VB"
        case .v0: return "V0"
        case .v1: return "V1"
        case .v2: return "V2"
        case .v3: return "V3"
        case .v4: return "V4"
        case .v5: return "V5"
        case .v6: return "V6"
        case .v7: return "V7"
        case .v8: return "V8"
        case .v9: return "V9"
        case .v10: return "V10"
        }
    }

    var id: Int16 { rawValue }
    
    var userDefaultsString: String {
        "\(displayName)_isPinned"
    }
}
