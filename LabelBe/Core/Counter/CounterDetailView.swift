//
//  CounterDetailView.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel: CounterDetailViewModel

    init(counter: Counter) {
        _viewModel = State(initialValue: CounterDetailViewModel(counter: counter))
    }

    var body: some View {
        VStack(spacing: 0) {
            SecondaryScreenHeaderView(title: viewModel.counter.name, onClose: dismiss)

            CounterDetailTabContentView(
                viewModel: viewModel,
                onMinus: { viewModel.recordTap(value: -1) },
                onPlus: { viewModel.recordTap(value: 1) }
            )

            CounterDetailTabBar(selectedTab: $viewModel.selectedTab)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
		  .animation(.easeInOut, value: viewModel.selectedTab)
        .background { AppBackgroundView() }
    }

    private func dismiss() {
        navigation.counterScreen = nil
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        CounterDetailView(counter: Counter(name: "Water", icon: "drop.fill"))
    }
    .environment(NavigationManager.shared)
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
