//
//  LogButtonsView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct LogButtonsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    @State private var showSheet = false

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
                showSheet = true
            },
            label: {
                Text(successful ? "👍" : "👎")
                    .font(.largeTitle)
            })
            .sheet(isPresented: $showSheet) {
                Grid {
                    ForEach(grades, id: \.0.id) { gradePair in
                        GridRow {
                            Button(gradePair.0.displayName) { log(grade: gradePair.0, successful: successful) }
                            Button(gradePair.1.displayName) { log(grade: gradePair.1, successful: successful) }
                        }
                        .padding()
                    }
                }
                .presentationDetents([.medium, .large])
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
        showSheet = false
        let climb = saveClimb(grade: grade, successful: successful)
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
}

struct LogButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LogButtonsView()
    }
}
