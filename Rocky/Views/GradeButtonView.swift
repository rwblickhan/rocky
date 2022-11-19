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

    init(_ grade: Grade, onSuccessAction: @escaping () -> Void, onFailureAction: @escaping () -> Void) {
        self.grade = grade
        self.onSuccessAction = onSuccessAction
        self.onFailureAction = onFailureAction
    }

    var body: some View {
        Button(action: {
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
            withAnimation {
                scale = 1.2
                expanded = true
            }
            Task {
                try? await Task.sleep(nanoseconds: 3_000_000_000)
                reset()
            }
        }, label: {
            HStack {
                label
            }
            .contentShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(.brown)
            .foregroundColor(.white)
            .cornerRadius(16)
            .scaleEffect(scale)
        })
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
            Spacer()
            Button(
                action: {
                    onFailureAction()
                    reset()
                },
                label: { Text("❌").font(.largeTitle) })
            Spacer()
            Button(
                action: {
                    onSuccessAction()
                    reset()
                },
                label: { Text("✅").font(.largeTitle) })
            Spacer()
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
