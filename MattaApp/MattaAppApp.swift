//
//  MattaAppApp.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 04/06/1445 AH.
//

import SwiftUI
import SwiftData

@main
struct MattaAppApp: App {
  @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
            } else {
                ContentView()
    
            }
        } .modelContainer(for: Destination.self)
    }
}


