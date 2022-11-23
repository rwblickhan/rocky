//
//  LogView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct LogView: View {
    @Environment(\.managedObjectContext) private var viewContext
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
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Climb Log")
            .toolbar { ToolbarItem(placement: .navigationBarTrailing) { EditButton() } }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { climbs[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
