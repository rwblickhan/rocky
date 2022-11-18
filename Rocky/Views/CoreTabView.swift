//
//  CoreTabView.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

struct CoreTabView: View {
    var body: some View {
        TabView {
            ClimbView()
                .tabItem {
                    Image(systemName: "figure.climbing")
                    Text(String(localized: "Climb"))
                }
            LogView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text(String(localized: "Log"))
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Stats")
                }
        }
    }
}

struct CoreTabView_Previews: PreviewProvider {
    static var previews: some View {
        CoreTabView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
