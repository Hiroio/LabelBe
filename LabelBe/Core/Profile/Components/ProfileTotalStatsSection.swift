//
//  ProfileTotalStatsSection.swift
//  LabelBe
//

import SwiftUI

struct ProfileTotalStatsSection: View {
    let breakdown: EntryBreakdown
    let monthPeriods: [MonthPeriodTotal]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total")
                .font(.headline)

            CounterStatsSummaryCard(
                breakdown: breakdown,
                accent: AppDesign.accent
            )

            Text("This Month")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            MonthPeriodChartView(
                data: monthPeriods,
                accent: AppDesign.accent
            )
        }
    }
}

#Preview {
    ProfileTotalStatsSection(
        breakdown: EntryBreakdown(pluses: 8, minuses: 2, total: 6),
        monthPeriods: [
            MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
            MonthPeriodTotal(id: 3, label: "22-28", total: 4, isCurrentPeriod: true),
        ]
    )
    .padding()
}
