//
//  PopupView.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import SwiftUI
import SwiftData

struct CreateView: View {
    
    // ==================== [ FIELDS ] ==================== //
    
    // Data storage
    @Environment(\.modelContext) private var context
    
    // Allows for closing
    @Environment(\.presentationMode) private var presentationMode
    
    // Mood data contents
    @State private var mood: Double = 4.0
    @State private var notes: String = ""
    
    // ==================== [ CONTENT ] ==================== //
    
    var body: some View {
        // Popup navigation
        NavigationView {
            VStack() {
                // Current Date
                Text(HomeView.dateFormat.string(from: Date()))
                    .padding(.bottom)
                
                HStack() {
                    Text("Awful")
                    Spacer()
                    Text("OK")
                    Spacer()
                    Text("Great")
                }
                .padding(.horizontal)
                .padding(.bottom, -5)
                
                // Mood slider
                Slider(value: Binding(
                    get: {
                        mood
                    },
                    set: { newMood in
                        mood = newMood.rounded()
                    }
                ), in: 0...8, step: 1)
                .padding(.horizontal)
                
                // Mood bar
                HStack() {
                    Text("😫")
                    Spacer()
                    Text("🙁")
                    Spacer()
                    Text("😐")
                    Spacer()
                    Text("🙂")
                    Spacer()
                    Text("😄")
                }
                .padding(.horizontal)
                .padding(.top, -5)
                
                // Notes input box
                ZStack(alignment: .topLeading) {
                    // Text editor
                    TextEditor(text: $notes)
                        .padding(.horizontal, 4)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color(UIColor.separator).opacity(0.7), lineWidth: 0.4)
                        )
                        .frame(height: 100)
                    
                    // Placeholder text
                    if notes.isEmpty {
                        Text("Enter notes")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                            .padding(.leading, 7)
                            .padding(.top, 9)
                    }
                }
                .padding()
//                TextField("Enter notes", text: $notes)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
                
                // Add to tracker
                Button("Add") {
                    addMood()
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            // Navigation bar settings
            .navigationTitle("Today I'm feeling...")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .background(Color.primaryBG)
        }
    }
    
    // ==================== [ METHODS ] ==================== //
    
    // Add mood
    private func addMood() -> Void {
        let newMood: MoodData = MoodData(
            Int(mood),
            time: Int(Date().timeIntervalSince1970),
            note: notes
        )
        context.insert(newMood)
        try? context.save()
    }
    
}
