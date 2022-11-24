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
                        onSuccessAction: { log(grade: gradePair.0, successful: true) },
                        onFailureAction: { log(grade: gradePair.0, successful: false) },
                        expandedGrade: $expandedGrade)
                    GradeButtonView(
                        grade: gradePair.1,
                        onSuccessAction: { log(grade: gradePair.1, successful: true) },
                        onFailureAction: { log(grade: gradePair.1, successful: false) },
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

    private func log(grade: Grade, successful: Bool) {
        let climb = saveClimb(grade: grade, successful: successful)
        let title = successful
            ? String(localized: "Good job!")
            : String(localized: "Aww, too bad...")

        Drops.show(Drop(
            title: title,
            action: Drop.Action(
                icon: UIImage(systemName: "arrow.uturn.backward"),
                handler: {
                    Drops.hideCurrent()
                    delete(climb: climb)
                })))
    }

    private func saveClimb(grade: Grade, successful: Bool) -> Climb {
        withAnimation {
            let newClimb = Climb(context: viewContext)
            newClimb.grade = grade.rawValue
            newClimb.successful = successful
            newClimb.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // swiftlint:disable no-warnings
                #warning("Replace this implementation with code to handle the error appropriately.")
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            return newClimb
        }
    }

    private func delete(climb: Climb) {
        withAnimation {
            viewContext.delete(climb)

            do {
                try viewContext.save()
            } catch {
                // swiftlint:disable no-warnings
                #warning("Replace this implementation with code to handle the error appropriately.")
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
