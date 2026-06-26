//
//  WeekComparisonTotalsChart.swift
//  LabelBe
//

import Charts
import SwiftUI

struct WeekComparisonTotalsChart: View {
    let comparison: WeekComparison
    let accent: Color

    private struct TotalPoint: Identifiable {
        let id: String
        let label: String
        let total: Int
    }

    private var points: [TotalPoint] {
        [
            TotalPoint(id: "current", label: "This Week", total: comparison.currentWeekTotal),
            TotalPoint(id: "previous", label: "Last Week", total: comparison.previousWeekTotal),
        ]
    }

    var body: some View {
        Chart(points) { point in
            BarMark(
                x: .value("Week", point.label),
                y: .value("Total", point.total)
            )
            .foregroundStyle(point.id == "current" ? accent : accent.opacity(0.35))
            .clipShape(.rect(cornerRadius: 4))
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 180)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    WeekComparisonTotalsChart(
        comparison: WeekComparison(currentWeekTotal: 42, previousWeekTotal: 28),
        accent: AppDesign.accent
    )
    .padding()
    .background(AppBackgroundView())
}
