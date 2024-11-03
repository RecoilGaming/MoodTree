//
//  MoodData.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import Foundation
import SwiftData

@Model
class MoodData : Identifiable {
    
    // ==================== [ FIELDS ] ==================== //
    
    var id: UUID
    var mood: Int
    var time: Int
    var activities: [ActivityData]
    var note: String
    
    // Constructor
    init(_ mood: Int, time: Int, activities: [ActivityData] = [], note: String = "") {
        self.id = UUID()
        self.mood = mood
        self.time = time
        self.activities = activities
        self.note = note
    }
    
    func getEmoji() -> String {
        switch mood {
            case 0, 1: return "😫";
            case 2, 3: return "🙁";
            case 5, 6: return "🙂";
            case 7, 8: return "😄";
            default: return "😐"
        }
    }
    
}
