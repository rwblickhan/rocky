//
//  GradePinToggleView.swift
//  Rocky
//
//  Created by Russell Blickhan on 12/14/22.
//

import SwiftUI

struct GradePinToggleView: View {
    private let grade: Grade
    private let userDefaults = UserDefaults.standard

    @State private var isOn: Bool

    init(grade: Grade) {
        self.grade = grade
        isOn = userDefaults.value(forKey: grade.userDefaultsString) as? Bool ?? true
    }

    var body: some View {
        Toggle(grade.displayName, isOn: $isOn)
            .onChange(of: isOn) {
                userDefaults.set($0, forKey: grade.userDefaultsString)
            }
    }
}

struct GradePinToggleView_Previews: PreviewProvider {
    static var previews: some View {
        GradePinToggleView(grade: .v0)
    }
}
