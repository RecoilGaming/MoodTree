//
//  MoodData.swift
//  MoodTree
//
//  Created by Qinzhao Li on 10/27/24.
//

import Foundation
import SwiftData

@Model
class ActivityData : Identifiable {
    
    // ==================== [ FIELDS ] ==================== //
    
    var id: UUID
    var name: String
    
    // Constructor
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
    
}
