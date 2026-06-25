//
//  MonthPeriodChartView.swift
//  LabelBe
//

import Charts
import SwiftUI

struct MonthPeriodChartView: View {
    let data: [MonthPeriodTotal]
    let accent: Color
    var showsBackground: Bool = true

    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Period", item.label),
                y: .value("Total", item.total)
            )
            .foregroundStyle(item.isCurrentPeriod ? accent : accent.opacity(0.35))
            .clipShape(.rect(cornerRadius: 4))
        }
        .chartXAxis {
            AxisMarks { _ in
                AxisGridLine()
                AxisValueLabel()
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .padding(showsBackground ? 16 : 0)
        .background {
            if showsBackground {
                RoundedRectangle(cornerRadius: AppDesign.cardCornerRadius, style: .continuous)
                    .fill(AppDesign.card)
            }
        }
    }
}

#Preview {
    MonthPeriodChartView(
        data: [
            MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
            MonthPeriodTotal(id: 1, label: "8-14", total: 5, isCurrentPeriod: false),
            MonthPeriodTotal(id: 2, label: "15-21", total: 1, isCurrentPeriod: false),
            MonthPeriodTotal(id: 3, label: "22-28", total: 3, isCurrentPeriod: true),
            MonthPeriodTotal(id: 4, label: "29-30", total: 0, isCurrentPeriod: false),
        ],
        accent: AppDesign.accent
    )
    .padding()
}
