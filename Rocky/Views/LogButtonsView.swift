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

    @State private var showSuccessfulSheet = false
    @State private var showUnsuccessfulSheet = false

    var body: some View {
        HStack {
            Spacer()
            unsuccessfulLogButton
            Spacer()
            successfulLogButton
            Spacer()
        }
    }

    private var unsuccessfulLogButton: some View {
        Button(action: { onTapLogButton(successful: false) }, label: { logButtonLabel(successful: false) })
            .sheet(isPresented: $showUnsuccessfulSheet) { gradeButtonGridView(succesful: false) }
    }

    private var successfulLogButton: some View {
        Button(action: { onTapLogButton(successful: true) }, label: { logButtonLabel(successful: true) })
            .sheet(isPresented: $showSuccessfulSheet) { gradeButtonGridView(succesful: true) }
    }

    private func logButtonLabel(successful: Bool) -> some View {
        Text(successful ? "👍" : "👎")
            .font(.largeTitle)
    }

    private func gradeButtonGridView(succesful: Bool) -> some View {
        GradeButtonGridView(onSelectGrade: { grade in
            log(grade: grade, successful: succesful)
        })
        .presentationDetents([.medium, .large])
    }

    private func onTapLogButton(successful: Bool) {
        impactMed.impactOccurred()
        showSuccessfulSheet = successful
        showUnsuccessfulSheet = !successful
    }

    private func log(grade: Grade, successful: Bool) {
        impactMed.impactOccurred()
        showSuccessfulSheet = false
        showUnsuccessfulSheet = false

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
        }
    }
}

struct LogButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LogButtonsView()
    }
}
