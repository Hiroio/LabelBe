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
        breakdown: EntryBreakdown(pluses: 10, minuses: 3, total: 7),
		  chartData: [DayTotal(date: .now, total: 3), DayTotal(date: .distantPast, total: 4)],
        accent: AppDesign.accent
    )
    .padding()
}
