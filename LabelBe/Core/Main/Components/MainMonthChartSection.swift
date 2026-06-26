//
//  MainMonthChartSection.swift
//  LabelBe
//

import SwiftUI

struct MainMonthChartSection: View {
    let monthPeriods: [MonthPeriodTotal]
    var onTap: (() -> Void)? = nil

    var body: some View {
        Group {
            if let onTap {
                Button(action: onTap) {
                    chartContent
                }
                .buttonStyle(.plain)
            } else {
                chartContent
            }
        }
    }

    private var chartContent: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            HStack {
                Text("Month")
                    .font(.headline)
                    .foregroundStyle(AppDesign.primaryText)

                Spacer()

                if onTap != nil {
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppDesign.accent)
                }
            }

            MonthPeriodChartView(
                data: monthPeriods,
                accent: AppDesign.accent,
                showsBackground: false
            )
        }
        .padding(AppDesign.spacingM)
    }
}

#Preview {
    MainMonthChartSection(
        monthPeriods: [
            MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
            MonthPeriodTotal(id: 3, label: "22-28", total: 4, isCurrentPeriod: true),
        ],
        onTap: {}
    )
    .padding()
    .background(AppBackgroundView())
}
