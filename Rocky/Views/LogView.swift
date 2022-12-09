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

    private struct DaySection: Identifiable {
        var climbs: [Climb]
        let timestamp: Date
        let id = UUID()
    }

    private var sections: [DaySection] {
        climbs.reduce(into: []) { partialResult, nextClimb in
            let nextClimbTimestamp = nextClimb.timestamp ?? Date()
            let climbBatchTimestamp = partialResult.last?.climbs.first?.timestamp ?? Date()
            if partialResult.isEmpty || !Calendar.current.isDate(nextClimbTimestamp, inSameDayAs: climbBatchTimestamp) {
                // Start a new batch
                partialResult.append(DaySection(climbs: [nextClimb], timestamp: nextClimbTimestamp))
            } else {
                // Append to the existing batch
                partialResult[partialResult.count - 1].climbs.append(nextClimb)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(sections) { section in
                        Section(header: Text(section.timestamp.formatted(.dateTime.day().month(.wide).year()))) {
                            ForEach(section.climbs) { LogClimbRowView(climb: $0) }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .headerProminence(.increased)
                .navigationTitle("Climb Log")
                .toolbar {
                    if !climbs.isEmpty {
                        ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: StatsView(), label: {
                            Text("Stats")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView(), label: {
                            Image(systemName: "gear")
                        })
                    }
                }
                Divider()
                LogButtonsView()
            }
            .listStyle(.inset)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { climbs[$0] }.forEach(viewContext.delete)

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

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
