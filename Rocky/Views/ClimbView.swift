//
//  ClimbView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import Drops
import SwiftUI

struct ClimbView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var expandedGrade: Grade?

    var body: some View {
        Grid {
            ForEach(grades, id: \.0.id) { gradePair in
                GridRow {
                    GradeButtonView(
                        grade: gradePair.0,
                        onSuccessAction: {
                            saveClimb(grade: gradePair.0, successful: true)
                            Drops.show(Drop(title: "Good job!", icon: UIImage(systemName: "checkmark")))
                        },
                        onFailureAction: {
                            saveClimb(grade: gradePair.0, successful: false)
                            Drops.show(Drop(title: "Aww, too bad", icon: UIImage(systemName: "xmark")))
                        },
                        expandedGrade: $expandedGrade)
                    GradeButtonView(
                        grade: gradePair.1,
                        onSuccessAction: {
                            saveClimb(grade: gradePair.1, successful: true)
                            Drops.show(Drop(title: "Good job!", icon: UIImage(systemName: "checkmark")))
                        },
                        onFailureAction: {
                            saveClimb(grade: gradePair.1, successful: false)
                            Drops.show(Drop(title: "Aww, too bad", icon: UIImage(systemName: "xmark")))
                        },
                        expandedGrade: $expandedGrade)
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

    private func saveClimb(grade: Grade, successful: Bool) {
        withAnimation {
            let newClimb = Climb(context: viewContext)
            newClimb.grade = grade.rawValue
            newClimb.successful = successful
            newClimb.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ClimbView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbView(expandedGrade: .v0)
    }
}
