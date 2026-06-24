//
//  MainView.swift
//  LabelBe
//

import SwiftUI

struct MainView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel = MainViewModel()
    @State private var createViewModel = CreateCounterViewModel()
    @State private var isShowingCreateSheet = false

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(title: "Labels") {
				  HStack{
					 headerAddButton(action: openCreation)
					 if !viewModel.counters.isEmpty {
						headerEditButton(action: openCreation)
					 }
				  }
            }

            if viewModel.counters.isEmpty {
                MainEmptyStateView(onAdd: openCreation)
            } else {
                MainCountersGrid(counters: viewModel.counters, onSelect: openCounter)
            }
        }
        .onAppear {
            viewModel.refreshCounters()
        }
        .sheet(isPresented: $isShowingCreateSheet) {
            CreateCounterSheet(viewModel: createViewModel, onCreate: submitNewCounter)
        }
        .onChange(of: isShowingCreateSheet) { _, isShowing in
            if !isShowing {
                createViewModel.reset()
            }
        }
    }

    private func openCreation() {
        isShowingCreateSheet = true
    }

    private func submitNewCounter() {
        viewModel.createCounter(
            name: createViewModel.trimmedName,
            icon: createViewModel.selectedIcon
        )
    }

    private func openCounter(_ counter: Counter) {
        navigation.counterScreen = .counter(counter)
    }
}

extension MainView {
    func headerAddButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "plus")
        }
        .buttonStyle(AccentCircleButtonStyle())
        .accessibilityLabel("Add")
    }
    func headerEditButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "pencil")
        }
        .buttonStyle(AccentCircleButtonStyle())
        .accessibilityLabel("Edit")
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        MainView()
    }
    .environment(NavigationManager.shared)
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
