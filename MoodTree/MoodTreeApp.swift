//
//  MoodTreeApp.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import SwiftUI
import SwiftData

@main
struct MoodTreeApp: App {
    
    // ==================== [ CONTENT ] ==================== //
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // Persistent data
        .modelContainer(for: [MoodData.self, ActivityData.self])
    }
    
}
