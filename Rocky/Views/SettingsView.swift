//
//  SettingsView.swift
//  Rocky
//
//  Created by Russell Blickhan on 12/8/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                ForEach(Grade.allCases) { grade in
                    GradePinToggleView(grade: grade)
                }
            } header: {
                Text("Pinned Grades")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
