//
//  GradeButtonView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct GradeButtonView: View {
    private let grade: Grade
    private let onSuccessAction: () -> Void
    private let onFailureAction: () -> Void

    @State private var expanded = false
    @State private var scale = 1.0

    private let impactMed = UIImpactFeedbackGenerator(style: .medium)

    init(_ grade: Grade, onSuccessAction: @escaping () -> Void, onFailureAction: @escaping () -> Void) {
        self.grade = grade
        self.onSuccessAction = onSuccessAction
        self.onFailureAction = onFailureAction
    }

    var body: some View {
        Button(action: {
            impactMed.impactOccurred()
            withAnimation {
                scale = 1.2
                expanded = true
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
            .scaleEffect(scale)
        })
        .onAppear {
            guard expanded else { return }
            reset()
        }
    }

    private func reset() {
        withAnimation {
            scale = 1.0
            expanded = false
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
        GradeButtonView(.v0, onSuccessAction: {}, onFailureAction: {})
    }
}
