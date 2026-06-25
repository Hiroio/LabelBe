//
//  AppTodayActivityCard.swift
//  LabelBe
//

import SwiftUI

struct AppTodayActivityCard: View {
    @Environment(NavigationManager.self) private var navigation
    let rows: [CounterPeriodRow]

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            Text("Today")
                .font(.headline)
                .foregroundStyle(AppDesign.primaryText)

            if rows.isEmpty {
                Text("No activity logged today yet.")
                    .font(.body)
                    .foregroundStyle(AppDesign.secondaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, AppDesign.spacingS)
            } else {
                VStack(spacing: AppDesign.spacingM) {
                    ForEach(rows) { row in
                        Button {
                            navigation.counterScreen = .counter(row.counter)
                        } label: {
                            CounterTodayRowView(row: row)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }
}

#Preview {
    AppTodayActivityCard(
        rows: [
            CounterPeriodRow(
                counter: Counter(name: "Water", icon: "drop.fill"),
                periodDelta: 5
            ),
        ]
    )
    .padding()
    .background(AppBackgroundView())
    .environment(NavigationManager.shared)
}
