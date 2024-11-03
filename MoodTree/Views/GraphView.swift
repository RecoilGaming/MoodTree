//
//  GraphView.swift
//  MoodTree
//
//  Created by Qinzhao Li on 11/1/24.
//

import SwiftUI
import SwiftData
import Charts

struct GraphView: View {
    
    // ==================== [ FIELDS ] ==================== //
    
    // Data storage
    @Query private var data: [MoodData]
    
    // Size of X-axis intevals
    let interval: Calendar.Component
        
    // ==================== [ CONTENT ] ==================== //

    var body: some View {
        // Allow graph scrolling
        ScrollView(.horizontal, showsIndicators: false) {
            Chart(data) { moodData in
                LineMark(
                    x: .value("Date", Date(timeIntervalSince1970: Double(moodData.time))),
                    y: .value("Mood", moodData.mood)
                )
                // Slightly rounded lines
                .interpolationMethod(.monotone)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: interval))
            }
            .chartYScale(domain: -1...9)
            .chartYAxis(.hidden)
            .frame(width: CGFloat(data.count) * 200)
        }
        .padding()
        .background(Color.secondaryBG.opacity(0.2))
    }
    
}
