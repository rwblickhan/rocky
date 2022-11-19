//
//  LogView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct LogView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Climb.timestamp, ascending: false)],
        animation: .default)
    private var climbs: FetchedResults<Climb>

    var body: some View {
        NavigationView {
            List {
                ForEach(climbs) { climb in
                    HStack {
                        Text("\(climb.successful ? "✅" : "❌")")
                        Text(Grade(rawValue: climb.grade)?.displayName ?? "null")
                        Text(climb.timestamp?.formatted() ?? "null")
                    }
                }
            }
            .navigationTitle("Climb Log")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) { editButton }
//                ToolbarItem(placement: .navigationBarTrailing) { addButton }
//            }
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
