//
//  MainTodaySummarySection.swift
//  LabelBe
//

import SwiftUI

struct MainTodaySummarySection: View {
    let breakdown: EntryBreakdown

    var body: some View {
        HStack(spacing: 0) {
            summaryColumn(title: "Plus", value: breakdown.pluses)
            summaryColumn(title: "Minus", value: breakdown.minuses)
            summaryColumn(title: "Total", value: breakdown.total, highlighted: true)
        }
        .padding(AppDesign.spacingM)
        .background(AppDesign.elevated, in: .rect(cornerRadius: AppDesign.inputCornerRadius))
    }

    private func summaryColumn(title: String, value: Int, highlighted: Bool = false) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppDesign.secondaryText)

            Text(value, format: .number)
                .font(.title3.weight(.semibold))
                .monospacedDigit()
                .foregroundStyle(highlighted ? AppDesign.accent : AppDesign.primaryText)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainTodaySummarySection(breakdown: EntryBreakdown(pluses: 8, minuses: 2, total: 6))
        .padding()
        .background(AppBackgroundView())
}
