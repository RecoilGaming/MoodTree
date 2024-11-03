//
//  ContentView.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import SwiftUI

struct ContentView: View {
    
    // ==================== [ FIELDS ] ==================== //
    
    // Tab & creation trackers
    @State private var isCreating: Bool = false
    @State private var currentTab: Int = 0
    
    // ==================== [ CONTENT ] ==================== //
    
    var body: some View {
        // Tabs
        TabView(selection: $currentTab) {
            
            // Home
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)
            
            // Add note
            Text("")
                .tabItem { Label("Track", systemImage: "plus.bubble.fill") }
                .tag(1)
            
            // Profile
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.crop.circle.fill") }
                .tag(2)
            
        }
        // Open note popup
        .onChange(of: currentTab) {
            if currentTab == 1 {
                isCreating = true
                currentTab = 0
            }
        }
        .sheet(isPresented: $isCreating) {
            // Set popup size
            CreateView()
                .presentationDetents([.fraction(0.7)])
                .presentationDragIndicator(.hidden)
        }
    }
    
}

// Tab bar formatting
extension UITabBarController {
    override open func viewDidLoad() {
        let a = UITabBarAppearance()
        
        // Edit spacing
        a.stackedItemPositioning = .centered
        a.stackedItemSpacing = 40
        a.stackedItemWidth = 60
        
        tabBar.standardAppearance = a
        tabBar.scrollEdgeAppearance = a
    }
}

#Preview {
    ContentView()
}
