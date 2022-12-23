//
//  StatsView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI
import Charts

struct StatsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Climb.timestamp, ascending: false)],
        animation: .default)
    private var climbs: FetchedResults<Climb>
    
    var body: some View {
        ScrollView {
            Text("Climbs per session")
            Chart(climbs.batched) {
                LineMark(
                    x: .value("Date", $0.timestamp),
                    y: .value("Number of climbs", $0.climbs.count))
            }
            .chartXAxisLabel("Date")
            .chartYAxisLabel("Climbs")
            Text("Successful climb ratio per session")
            Chart(climbs.batched) {
                LineMark(
                    x: .value("Date", $0.timestamp),
                    y: .value("Ratio of successful climbs", $0.successRate))
            }
            .chartXAxisLabel("Date")
            .chartYAxisLabel("Success ratio")
        }
        .padding()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
