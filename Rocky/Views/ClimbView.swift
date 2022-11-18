//
//  ClimbView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct ClimbView: View {
    var body: some View {
        Grid() {
            ForEach(grades, id: \.0.id) { gradePair in
                GridRow {
                    GradeButtonView(gradePair.0)
                    GradeButtonView(gradePair.1)
                }
            }
        }
    }
    
    private var grades: [(Grade, Grade)] {
        var grades = [(Grade, Grade)]()
        for i in stride(from: 0, to: Grade.allCases.count - 1, by: 2) {
            grades.append((Grade.allCases[i], Grade.allCases[i+1]))
        }
        return grades
    }
}

struct ClimbView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbView()
    }
}
