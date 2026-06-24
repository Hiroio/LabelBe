//
//  CounterTodayChartView.swift
//  LabelBe
//

import Charts
import SwiftUI

struct CounterTodayChartView: View {
    let data: [DayTotal]
    let accent: Color

    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Day", item.shortWeekday),
                y: .value("Total", item.total)
            )
            .foregroundStyle(accent.gradient)
            .clipShape(.rect(cornerRadius: 4))
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .frame(height: 160)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.background, in: .rect(cornerRadius: AppDesign.cardCornerRadius))
    }
}

#Preview {
    CounterTodayChartView(
        data: [
            DayTotal(date: .now, total: 5)
        ],
        accent: .indigo
    )
    .padding()
}
