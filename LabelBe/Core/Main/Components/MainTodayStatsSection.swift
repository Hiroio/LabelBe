//
//  MainTodayStatsSection.swift
//  LabelBe
//

import SwiftUI

struct MainTodayStatsSection: View {
    @Environment(NavigationManager.self) private var navigation
    let rows: [CounterPeriodRow]

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            HStack {
                Text("Today")
                    .font(.headline)
                    .foregroundStyle(AppDesign.primaryText)

                Spacer()
            }

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
    }
}

#Preview {
    MainTodayStatsSection(
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
