//
//  GradeButtonGridView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct GradeButtonGridView: View {
    let successful: Bool
    let onSelectGrade: (Grade) -> Void

    let userDefaults = UserDefaults.standard

    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        VStack {
            Spacer()
            Text(successful ? "Successful Climb" : "Unsuccessful Climb")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .font(.title)
            Grid {
                ForEach(grades, id: \.0.id) { gradePair in
                    GridRow {
                        GradeButtonView(grade: gradePair.0, onSelectGrade: onSelectGrade)
                        if let secondGrade = gradePair.1 {
                            GradeButtonView(grade: secondGrade, onSelectGrade: onSelectGrade)
                        }
                    }
                    .padding()
                }
            }
        }
    }

    private var grades: [(Grade, Grade?)] {
        let visibleGrades = Array(Grade.allCases.filter {
            userDefaults.value(forKey: $0.userDefaultsString) as? Bool ?? true
        }.reversed())
        var gradePairs = [(Grade, Grade?)]()
        for i in stride(from: 0, to: visibleGrades.count, by: 2) {
            if i + 1 >= visibleGrades.count {
                gradePairs.append((visibleGrades[i], nil))
            } else {
                gradePairs.append((visibleGrades[i], visibleGrades[i + 1]))
            }
        }
        return gradePairs
    }
}

struct GradeGridView_Previews: PreviewProvider {
    static var previews: some View {
        GradeButtonGridView(successful: true) { _ in }
        GradeButtonGridView(successful: false) { _ in }
    }
}
