//
//  LogClimbRowView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/25/22.
//

import SwiftUI

struct LogClimbRowView: View {
    @State var climb: Climb

    var body: some View {
        HStack {
            Text("\(climb.successful ? "✅" : "❌")")
            Text(Grade(rawValue: climb.grade)?.displayName ?? "null")
            Text(climb.timestamp?.formatted() ?? "null")
        }
    }
}

struct LogClimbRowView_Previews: PreviewProvider {
    static var previews: some View {
        LogClimbRowView(climb: Climb())
    }
}
