//
//  CounterStatsMonthCard.swift
//  LabelBe
//

import SwiftUI

struct CounterStatsMonthCard: View {
    @Binding var currentMonth: Date
    let chartData: [MonthPeriodTotal]
    let accent: Color

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            HStack {
                Text("Month")
                    .font(.headline)
                    .foregroundStyle(AppDesign.primaryText)

                Spacer()

                CustomMonthStepper(date: $currentMonth)
                    .foregroundStyle(accent)
            }

            MonthPeriodChartView(data: chartData, accent: accent, showsBackground: false)
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
        .animation(.easeInOut, value: currentMonth)
    }
}

#Preview {
    CounterStatsMonthCard(
        currentMonth: .constant(.now),
        chartData: [
            MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
            MonthPeriodTotal(id: 3, label: "22-28", total: 3, isCurrentPeriod: true),
        ],
        accent: AppDesign.accent
    )
    .padding()
    .background(AppBackgroundView())
}
