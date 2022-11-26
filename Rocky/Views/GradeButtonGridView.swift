//
//  GradeButtonGridView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct GradeButtonGridView: View {
    let onSelectGrade: (Grade) -> Void

    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        Grid {
            ForEach(grades, id: \.0.id) { gradePair in
                GridRow {
                    gradeButton(grade: gradePair.0)
                    gradeButton(grade: gradePair.1)
                }
                .padding()
            }
        }
    }

    private var grades: [(Grade, Grade)] {
        let allGrades = Array(Grade.allCases.reversed())
        var gradePairs = [(Grade, Grade)]()
        for i in stride(from: 0, to: allGrades.count - 1, by: 2) {
            gradePairs.append((allGrades[i], allGrades[i + 1]))
        }
        return gradePairs
    }

    @ViewBuilder
    private func gradeButton(grade: Grade) -> some View {
        Button(grade.displayName) { onSelectGrade(grade) }
    }
}

struct GradeGridView_Previews: PreviewProvider {
    static var previews: some View {
        GradeButtonGridView { _ in }
    }
}
