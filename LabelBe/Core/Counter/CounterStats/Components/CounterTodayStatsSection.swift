//
//  CounterTodayStatsSection.swift
//  LabelBe
//

import SwiftUI

struct CounterTodayStatsSection: View {
    let breakdown: EntryBreakdown
    let chartData: [DayTotal]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("By day")
                .font(.headline)

            CounterStatsSummaryCard(breakdown: breakdown, accent: accent)

            CounterTodayChartView(data: chartData, accent: accent)
        }
    }
}

#Preview {
    CounterTodayStatsSection(
        breakdown: EntryBreakdown(pluses: 4, minuses: 1, total: 3),
        chartData: [DayTotal(date: .now, total: 3)],
        accent: .indigo
    )
    .padding()
}
