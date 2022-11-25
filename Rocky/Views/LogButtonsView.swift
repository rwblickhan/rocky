//
//  LogButtonsView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct LogButtonsView: View {
    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        HStack {
            Spacer()
            logButton(successful: false)
            Spacer()
            logButton(successful: true)
            Spacer()
        }
    }

    @ViewBuilder
    private func logButton(successful: Bool) -> some View {
        Button(
            action: {
                impactMed.impactOccurred()
            },
            label: {
                Text(successful ? "👍" : "👎")
                    .font(.largeTitle)
            })
    }
}

struct LogButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LogButtonsView()
    }
}
