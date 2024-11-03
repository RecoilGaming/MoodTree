//
//  ContentView.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // ==================== [ FIELDS ] ==================== //
    
    // Data storage
    @Environment(\.modelContext) private var context
    @Query private var data: [MoodData]
    
    // Deleting confirmation
    @State private var isConfirming: Bool = false
    @State private var currentMood: MoodData?
    
    // Sorted data
    private var sortedData: [Int: [MoodData]] {
        Dictionary(grouping: data) { moodData in
            Int(Calendar.current.startOfDay(for: Date(timeIntervalSince1970: TimeInterval(moodData.time))).timeIntervalSince1970)
        }
    }
    
    // Date formatter
    static let dateFormat: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        return format
    }()
    
    // ==================== [ CONTENT ] ==================== //

    var body: some View {
        VStack {
            List {
                // Title
                Text("MoodTree 🌴")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .listRowBackground(Color.primaryBG)
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                // Graph
                GraphView(interval: .hour)
                    .listRowBackground(Color.primaryBG)
                    .listRowSeparator(.hidden)
                    .padding()
                
                // Notes
                ForEach(sortedData.keys.sorted(by: >), id: \.self) { date in
                    // Date based sections
                    Section(header: Text(HomeView.dateFormat.string(from: Date(timeIntervalSince1970: TimeInterval(date))))) {
                        // Show notes per-date
                        ForEach(sortedData[date] ?? []) { moodData in
                            HStack {
                                // Mood emoji
                                Text(moodData.getEmoji())
                                
                                // Note text
                                Text(moodData.note)
                                    .font(.headline)
                                
                                Spacer()
                                
                                // Trash button
                                Button(action: {
                                    currentMood = moodData
                                    isConfirming = true
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                // Make button not take entire line
                                .buttonStyle(BorderlessButtonStyle())
                                
                                // Confirmation before deleting
                                .alert(isPresented: $isConfirming) {
                                    Alert(
                                        title: Text("Are you sure?"),
                                        message: Text("This action will permanently delete the item."),
                                        primaryButton: .destructive(Text("Delete")) {
                                            if let mood = currentMood {
                                                delMood(moodData: mood)
                                            }
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                            }
                            // Slightly darker background on notes
                            .listRowBackground(Color.secondaryBG.opacity(0.2))
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            // Group by dates
            .listStyle(GroupedListStyle())
            
            // Display background color
            .scrollContentBackground(.hidden)
            
            Spacer()
            
        }
        .background(Color.primaryBG)
    }
    
    // ==================== [ METHODS ] ==================== //
    
    // Delete mood
    private func delMood(moodData: MoodData) -> Void {
        context.delete(moodData)
        try? context.save()
    }
}
