//
//  RoundedRectangleButtonStyle.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import Foundation
import SwiftUI

/// https://www.fivestars.blog/articles/button-styles/
struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label.foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color.purple.cornerRadius(16))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
