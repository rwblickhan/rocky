//
//  GradeButtonView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct GradeButtonView: View {
    let grade: Grade
    let onSelectGrade: (Grade) -> Void

    @State private var isPressed = false

    var body: some View {
        Button(
            action: {
                isPressed.toggle()
                onSelectGrade(grade)
            },
            label: {
                Text(grade.displayName)
                    .font(.largeTitle)
            })
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct GradeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GradeButtonView(grade: .v0) { _ in }
    }
}
