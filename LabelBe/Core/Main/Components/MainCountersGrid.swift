//
//  MainCountersGrid.swift
//  LabelBe
//

import SwiftUI

struct MainCountersGrid: View {
    let counters: [Counter]
    let onSelect: (Counter) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppDesign.gridSpacing) {
                ForEach(counters, id: \.id) { counter in
                    Button {
                        onSelect(counter)
                    } label: {
                        CounterCardView(counter: counter)
                    }
                    .buttonStyle(CounterCardButtonStyle())
                }
            }
            .padding(.horizontal, AppDesign.gridPadding)
            .padding(.bottom, 12)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    MainCountersGrid(
        counters: [
            Counter(name: "Water", icon: "drop.fill"),
            Counter(name: "Run", icon: "figure.run"),
        ],
        onSelect: { _ in }
    )
}
