//
//  CounterTodayRowView.swift
//  LabelBe
//

import SwiftUI

struct CounterTodayRowView: View {
    let row: CounterPeriodRow

    private var accent: Color {
        AppDesign.cardAccent(for: row.counter.id)
    }

    var body: some View {
        HStack(spacing: AppDesign.spacingM) {
            Image(systemName: row.counter.icon)
                .font(.body)
                .foregroundStyle(accent)
                .accentIconBadge(color: accent, size: 36)

            VStack(alignment: .leading, spacing: AppDesign.spacingS) {
                Text(row.counter.name)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(AppDesign.primaryText)
                    .lineLimit(1)

                Text("Today")
                    .font(.caption)
                    .foregroundStyle(AppDesign.secondaryText)
            }

            Spacer()

            Text(signedDelta(row.periodDelta))
                .font(.title3.weight(.semibold))
                .monospacedDigit()
                .foregroundStyle(accent)
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }

    private func signedDelta(_ value: Int) -> String {
        value > 0 ? "+\(value)" : "\(value)"
    }
}

#Preview {
    CounterTodayRowView(
        row: CounterPeriodRow(
            counter: Counter(name: "Water", icon: "drop.fill"),
            periodDelta: 5
        )
    )
    .padding()
    .background(AppBackgroundView())
}
