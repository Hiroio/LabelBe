//
//  CounterGridView.swift
//  LabelBe
//

import SwiftUI

struct CounterGridView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel = CounterGridViewModel()
    @State private var createViewModel = CreateCounterViewModel()

    var body: some View {
        VStack(spacing: AppDesign.spacingM) {
            header

            if !viewModel.allTags.isEmpty {
                TagScroll(
                    tags: viewModel.allTags,
                    selectedTag: $viewModel.selectedTag
                )
                .padding(.horizontal, AppDesign.screenPadding)
            }

            if viewModel.filteredCounters.isEmpty {
                GridEmptyStateView {
                    viewModel.openCreation()
                }
            } else {
                MainCountersGrid(
                    counters: viewModel.filteredCounters,
                    onSelect: openCounter,
                    onDelete: selectForDeletion,
                    editingState: viewModel.isEditing
                )
            }
        }
        .onAppear {
            viewModel.refreshCounters()
        }
        .sheet(isPresented: $viewModel.isShowingCreateSheet) {
            CreateCounterSheet(viewModel: createViewModel) {
                viewModel.createCounter(
                    name: createViewModel.trimmedName,
                    icon: createViewModel.selectedIcon,
                    tags: createViewModel.tags
                )
            }
        }
        .onChange(of: viewModel.isShowingCreateSheet) { _, isShowing in
            if !isShowing {
                createViewModel.reset()
            }
        }
        .alert("Are you Sure?", isPresented: Binding(
            get: { viewModel.selectedCounter != nil },
            set: { if !$0 { viewModel.selectedCounter = nil } }
        )) {
            Button("Delete", role: .destructive) {
                viewModel.deleteCounter()
            }
        } message: {
            Text("This action can't be undone")
        }
    }

    private func openCounter(_ counter: Counter) {
        navigation.counterScreen = .counter(counter)
    }

    private func selectForDeletion(_ counter: Counter) {
        withAnimation {
            viewModel.selectedCounter = counter
        }
    }
}

extension CounterGridView {
    private var header: some View {
        HStack {
            Text("Counters")
                .font(.title2.weight(.semibold))
                .foregroundStyle(AppDesign.primaryText)

            Spacer()

            Menu {
                Picker("Sort", selection: $viewModel.sortFilter) {
                    ForEach(CounterGridSortEnum.allCases) { sort in
                        Text(sort.title).tag(sort)
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(AppDesign.accent, in: .circle)
            }
            .accessibilityLabel("Sort counters")

            Button(action: viewModel.openCreation) {
                Image(systemName: "plus")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(AppDesign.accent, in: .circle)
            }
            .accessibilityLabel("Add counter")

            Button {
                withAnimation(AppDesign.quickAnimation) {
                    viewModel.isEditing.toggle()
                }
            } label: {
                Image(systemName: viewModel.isEditing ? "xmark" : "trash")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(viewModel.isEditing ? AppDesign.elevated : AppDesign.accent, in: .circle)
            }
            .accessibilityLabel(viewModel.isEditing ? "Cancel delete mode" : "Delete counter")
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, AppDesign.spacingM)
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        CounterGridView()
    }
    .environment(NavigationManager.shared)
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
