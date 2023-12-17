//
//  MattaAppApp.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 04/06/1445 AH.
//

import SwiftUI

@main
struct MattaAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
