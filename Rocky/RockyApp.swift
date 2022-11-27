//
//  RockyApp.swift
//  Rocky
//
//  Created by Russell Blickhan on 11/17/22.
//

import Sentry
import SwiftUI

@main
struct RockyApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        SentrySDK.start { options in
            options
                .dsn =
                "https://ec56232ad63b4c41851b5d1ab88799c1@o4504233599172608.ingest.sentry.io/4504233600155648"
            options.debug = true // Enabled debug when first installing is always helpful

            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0

            // Features turned off by default, but worth checking out
            options.enableAppHangTracking = true
            options.enableFileIOTracking = true
            options.enableCoreDataTracking = true
            options.enableCaptureFailedRequests = true
        }
    }

    var body: some Scene {
        WindowGroup {
            LogView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
