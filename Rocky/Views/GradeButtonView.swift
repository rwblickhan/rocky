//
//  GradeButtonView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct GradeButtonView: View {
    let grade: Grade
    let onSuccessAction: () -> Void
    let onFailureAction: () -> Void

    @Binding var expandedGrade: Grade?
    @State private var scale = 1.0

    private var expanded: Bool { grade == expandedGrade }

    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        Button(action: {
            impactMed.impactOccurred()
            withAnimation {
                expandedGrade = grade
            }
        }, label: {
            HStack {
                label
            }
            .contentShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.brown)
            .foregroundColor(.white)
            .cornerRadius(16)
            .scaleEffect(expanded ? 1.1 : 1.0)
        })
        .onAppear {
            guard expanded else { return }
            reset()
        }
    }

    private func reset() {
        withAnimation {
            expandedGrade = nil
        }
    }

    @ViewBuilder
    private var label: some View {
        if expanded {
            Button(
                action: {
                    impactMed.impactOccurred()
                    onFailureAction()
                    reset()
                },
                label: {
                    Text("👎")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.red)
                        .contentShape(Rectangle())
                })
            Button(
                action: {
                    impactMed.impactOccurred()
                    onSuccessAction()
                    reset()
                },
                label: {
                    Text("👍")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.green)
                        .contentShape(Rectangle())
                })
        } else {
            Text(grade.displayName)
                .font(.largeTitle)
        }
    }
}

struct GradeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GradeButtonView(grade: .v0, onSuccessAction: {}, onFailureAction: {}, expandedGrade: .constant(.v1))
        GradeButtonView(grade: .v0, onSuccessAction: {}, onFailureAction: {}, expandedGrade: .constant(.v0))
    }
}
