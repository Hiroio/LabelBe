//
//  WeekComparisonDaysChart.swift
//  LabelBe
//

import Charts
import SwiftUI

struct WeekComparisonDaysChart: View {
    let points: [WeekChartPoint]
    let accent: Color

    var body: some View {
        Chart(points) { point in
            BarMark(
                x: .value("Day", point.day),
                y: .value("Total", point.total)
            )
            .foregroundStyle(by: .value("Period", point.period))
            .position(by: .value("Period", point.period))
            .clipShape(.rect(cornerRadius: 3))
        }
        .chartForegroundStyleScale([
            "This Week": accent,
            "Last Week": accent.opacity(0.35),
        ])
        .chartLegend(position: .bottom, alignment: .center)
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 220)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeekComparisonDaysChart(
        points: [
            WeekChartPoint(id: "Mon-c", day: "Mon", period: "This Week", total: 5),
            WeekChartPoint(id: "Mon-p", day: "Mon", period: "Last Week", total: 3),
        ],
        accent: AppDesign.accent
    )
    .padding()
    .background(AppBackgroundView())
}
