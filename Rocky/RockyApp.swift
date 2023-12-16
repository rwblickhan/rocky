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
    init() {
        SentrySDK.start { options in
            options
                .dsn =
                "https://ec56232ad63b4c41851b5d1ab88799c1@o4504233599172608.ingest.sentry.io/4504233600155648"
            options.debug = true
            options.tracesSampleRate = 1.0
            options.enableAppHangTracking = true
            options.enableFileIOTracking = true
            options.enableCoreDataTracking = true
            options.enableCaptureFailedRequests = true
        }
    }

    var body: some Scene {
        WindowGroup {
            LogView()
                .modelContainer(for: Climb.self)
        }
    }
}
