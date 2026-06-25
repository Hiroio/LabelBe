//
//  MainLatestCountersSection.swift
//  LabelBe
//

import SwiftUI

struct MainLatestCountersSection: View {
    @Environment(NavigationManager.self) private var navigation
    let counters: [Counter]

    private var displayedCounters: [Counter] {
        Array(counters.prefix(2))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            Text("Latest Interaction")
                .font(.headline)
                .foregroundStyle(AppDesign.primaryText)

            HStack(spacing: AppDesign.gridSpacing) {
                ForEach(displayedCounters, id: \.id) { counter in
                    Button {
                        navigation.counterScreen = .counter(counter)
                    } label: {
                        CounterCardView(counter: counter)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }
}

#Preview {
    MainLatestCountersSection(
        counters: [
            Counter(name: "Water", icon: "drop.fill"),
            Counter(name: "Run", icon: "figure.run"),
        ]
    )
    .padding()
    .background(AppBackgroundView())
    .environment(NavigationManager.shared)
}
