//
//  MainMonthChartSection.swift
//  LabelBe
//

import SwiftUI

struct MainMonthChartSection: View {
    let monthPeriods: [MonthPeriodTotal]

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            Text("Month")
                .font(.headline)
                .foregroundStyle(AppDesign.primaryText)

            MonthPeriodChartView(
                data: monthPeriods,
                accent: AppDesign.accent,
                showsBackground: false
            )
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }
}

#Preview {
    MainMonthChartSection(
        monthPeriods: [
            MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
            MonthPeriodTotal(id: 3, label: "22-28", total: 4, isCurrentPeriod: true),
        ]
    )
    .padding()
    .background(AppBackgroundView())
}
