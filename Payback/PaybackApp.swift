//
//  PaybackApp.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

@main
struct PaybackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
