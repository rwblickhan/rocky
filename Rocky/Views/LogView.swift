//
//  LogView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftData
import SwiftUI

struct LogView: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: [SortDescriptor(\Climb.timestamp, order: .reverse)], animation: .default)
    private var climbs: [Climb]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(climbs.batched) { batch in
                        Section(header: Text(batch.timestamp.formatted(.dateTime.day().month(.wide).year()))) {
                            ForEach(batch.climbs) { LogClimbRowView(climb: $0) }
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
            offsets.map { climbs[$0] }.forEach(modelContext.delete)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView()
    }
}
