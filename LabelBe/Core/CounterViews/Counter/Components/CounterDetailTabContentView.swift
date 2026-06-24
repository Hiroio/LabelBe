//
//  CounterDetailTabContentView.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailTabContentView: View {
    let viewModel: CounterDetailViewModel
    let onMinus: () -> Void
    let onPlus: () -> Void

    var body: some View {
        ZStack {
            CounterDetailCounterTabView(
                viewModel: viewModel,
                onMinus: onMinus,
                onPlus: onPlus
            )
            .opacity(viewModel.selectedTab == .counter ? 1 : 0)
            .allowsHitTesting(viewModel.selectedTab == .counter)

            CounterStatsView(counter: viewModel.counter)
                .id(viewModel.refreshID)
                .opacity(viewModel.selectedTab == .stats ? 1 : 0)
                .allowsHitTesting(viewModel.selectedTab == .stats)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    CounterDetailTabContentView(
        viewModel: CounterDetailViewModel(counter: Counter(name: "Water", icon: "drop.fill")),
        onMinus: {},
        onPlus: {}
    )
}
