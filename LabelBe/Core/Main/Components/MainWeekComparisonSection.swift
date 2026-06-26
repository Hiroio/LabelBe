//
//  MainWeekComparisonSection.swift
//  LabelBe
//

import SwiftUI

struct MainWeekComparisonSection: View {
    let comparison: WeekComparison
    var onTap: (() -> Void)? = nil

    var body: some View {
        Group {
            if let onTap {
                Button(action: onTap) {
                    content
                }
                .buttonStyle(.plain)
            } else {
                content
            }
        }
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            HStack {
                Text("Week Comparison")
                    .font(.headline)
                    .foregroundStyle(AppDesign.primaryText)

                Spacer()

                if onTap != nil {
                    Image(systemName: "chevron.right")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(AppDesign.accent)
                }
            }

            HStack(spacing: AppDesign.spacingM) {
                weekColumn(title: "This Week", value: comparison.currentWeekTotal)
                weekColumn(title: "Last Week", value: comparison.previousWeekTotal)

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {
                    Text(comparison.deltaText)
                        .font(.title3.weight(.bold))
                        .monospacedDigit()
                        .foregroundStyle(deltaColor)

                    Text("vs last week")
                        .font(.caption)
                        .foregroundStyle(AppDesign.secondaryText)
                }
            }
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }

    private var deltaColor: Color {
        if comparison.delta > 0 { return AppDesign.accent }
        if comparison.delta < 0 { return Color.red.opacity(0.85) }
        return AppDesign.secondaryText
    }

    private func weekColumn(title: String, value: Int) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(AppDesign.secondaryText)

            Text(value, format: .number)
                .font(.title2.weight(.semibold))
                .monospacedDigit()
                .foregroundStyle(AppDesign.primaryText)
        }
    }
}

#Preview {
    MainWeekComparisonSection(
        comparison: WeekComparison(currentWeekTotal: 42, previousWeekTotal: 35),
        onTap: {}
    )
    .padding()
    .background(AppBackgroundView())
}
