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

    private var batchedClimbs: [(climbs: [Climb], timestamp: Date)] {
        climbs.reduce(into: []) { partialResult, nextClimb in
            let nextClimbTimestamp = nextClimb.timestamp ?? Date()
            let climbBatchTimestamp = partialResult.last?.0.first?.timestamp ?? Date()
            if partialResult.isEmpty || !Calendar.current.isDate(nextClimbTimestamp, inSameDayAs: climbBatchTimestamp) {
                // Start a new batch
                partialResult.append((climbs: [nextClimb], timestamp: nextClimbTimestamp))
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
                    ForEach(batchedClimbs, id: \.timestamp) { batch in
                        Section {
                            ForEach(batch.climbs) { climb in
                                LogClimbRowView(climb: climb)
                            }
                        } header: {
                            Text(batch.timestamp.formatted(.dateTime.day().month(.wide).year()))
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
                    ToolbarItem(placement: .navigationBarTrailing) { NavigationLink(destination: StatsView(), label: {
                        Text("Stats")
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
