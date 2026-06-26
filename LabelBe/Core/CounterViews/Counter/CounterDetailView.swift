//
//  CounterDetailView.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel: CounterDetailViewModel
    @State private var editViewModel = CreateCounterViewModel()
    @State private var isShowingEditSheet = false

    init(counter: Counter) {
        _viewModel = State(initialValue: CounterDetailViewModel(counter: counter))
    }

    var body: some View {
        VStack(spacing: 0) {
            CounterDetailHeaderView(
                title: viewModel.counter.name,
                tags: viewModel.tags,
                isPinned: viewModel.isPinned,
                onClose: dismiss,
                onEdit: openEdit,
                onTogglePin: viewModel.togglePin
            )

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
        .sheet(isPresented: $isShowingEditSheet) {
            EditCounterSheet(viewModel: editViewModel) {
                viewModel.saveChanges(
                    name: editViewModel.trimmedName,
                    icon: editViewModel.selectedIcon,
                    tags: editViewModel.tags
                )
            }
        }
    }

    private func dismiss() {
        navigation.counterScreen = nil
    }

    private func openEdit() {
        editViewModel.load(from: viewModel.counter)
        isShowingEditSheet = true
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
