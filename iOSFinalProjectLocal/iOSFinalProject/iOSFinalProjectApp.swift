//
//  iOSFinalProjectApp.swift
//  iOSFinalProject
//
//  Created by Trainee on 12/31/24.
//

import SwiftUI

@main
struct iOSFinalProjectApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        _ = DependencyInitializer()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
