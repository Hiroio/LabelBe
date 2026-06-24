//
//  CounterStatsSummaryCard.swift
//  LabelBe
//

import SwiftUI

struct CounterStatsSummaryCard: View {
    let breakdown: EntryBreakdown
    let accent: Color

    var body: some View {
        HStack(spacing: 0) {
            summaryColumn(title: "Plus", value: breakdown.pluses)
            summaryColumn(title: "Minus", value: breakdown.minuses)
            summaryColumn(title: "Total", value: breakdown.total)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.background, in: .rect(cornerRadius: AppDesign.cardCornerRadius))
    }

    private func summaryColumn(title: String, value: Int) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value, format: .number)
                .font(.title2)
                .bold()
                .monospacedDigit()
                .foregroundStyle(title == "Total" ? accent : .primary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CounterStatsSummaryCard(
        breakdown: EntryBreakdown(pluses: 5, minuses: 2, total: 3),
        accent: .indigo
    )
    .padding()
}
