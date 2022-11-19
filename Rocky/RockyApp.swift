//
//  RockyApp.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import SwiftUI

@main
struct RockyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CoreTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
