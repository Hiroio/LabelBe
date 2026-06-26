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

            if viewModel.showsSearchFilters {
                GridSearchField(text: $viewModel.searchText)
                    .padding(.horizontal, AppDesign.screenPadding)

                if !viewModel.allTags.isEmpty {
                    TagScroll(
                        tags: viewModel.allTags,
                        selectedTag: $viewModel.selectedTag
                    )
                    .padding(.horizontal, AppDesign.screenPadding)
                }
            }

            gridContent
        }
        .animation(.default, value: viewModel.showsArchived)
        .animation(.default, value: viewModel.isEditing)
        .animation(.default, value: viewModel.displayedCounters.map(\.id))
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
        .alert(alertTitle, isPresented: Binding(
            get: { viewModel.selectedCounter != nil },
            set: { if !$0 { viewModel.cancelPendingAction() } }
        )) {
            Button(alertConfirmTitle, role: .destructive) {
                viewModel.confirmAction()
            }
        } message: {
            Text(alertMessage)
        }
    }

    @ViewBuilder
    private var gridContent: some View {
        switch viewModel.gridContent {
        case .createEmpty:
            GridEmptyStateView {
                viewModel.openCreation()
            }
        case .archivedEmpty:
            GridNoResultsView(
                title: "No archived counters",
                message: "Counters you archive will appear here."
            )
        case .noResults:
            GridNoResultsView()
        case .grid:
            MainCountersGrid(
                counters: viewModel.displayedCounters,
                isEditing: viewModel.isEditing,
                editIcon: viewModel.editCellIcon,
                showsRestore: viewModel.showsRestoreInEdit,
                onSelect: openCounter,
                onEdit: viewModel.handleEditTap,
                onRestore: viewModel.restoreCounter
            )
        }
    }

    private var alertTitle: String {
        viewModel.pendingAction == .delete ? "Delete Permanently?" : "Archive Counter?"
    }

    private var alertConfirmTitle: String {
        viewModel.pendingAction == .delete ? "Delete" : "Archive"
    }

    private var alertMessage: String {
        viewModel.pendingAction == .delete
            ? "This counter and all history will be removed forever."
            : "You can restore this counter later from Archived."
    }

    private func openCounter(_ counter: Counter) {
        navigation.counterScreen = .counter(counter)
    }
}

extension CounterGridView {
    private var header: some View {
        HStack(spacing: AppDesign.spacingS) {
            Button {
                viewModel.toggleArchivedView()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(AppDesign.elevated, in: .circle)
            }
            .opacity(viewModel.showsArchived ? 1 : 0)
            .allowsHitTesting(viewModel.showsArchived)
            .accessibilityLabel("Back to counters")

            Text(viewModel.headerTitle)
                .font(.title2.weight(.semibold))
                .foregroundStyle(AppDesign.primaryText)

            Spacer()

            HStack(spacing: AppDesign.spacingS) {
                Menu {
                    Picker("Sort", selection: $viewModel.sortFilter) {
                        ForEach(CounterGridSortEnum.allCases) { sort in
                            Text(sort.title).tag(sort)
                        }
                    }

                    Button("Archived") {
                        viewModel.toggleArchivedView()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppDesign.primaryText)
                        .frame(width: 40, height: 40)
                        .background(AppDesign.accent, in: .circle)
                }
                .accessibilityLabel("Sort and filters")

                Button(action: viewModel.openCreation) {
                    Image(systemName: "plus")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(AppDesign.primaryText)
                        .frame(width: 40, height: 40)
                        .background(AppDesign.accent, in: .circle)
                }
                .accessibilityLabel("Add counter")
            }
            .opacity(viewModel.showsArchived ? 0 : 1)
            .allowsHitTesting(!viewModel.showsArchived)

            Button(action: viewModel.toggleEditing) {
                Image(systemName: viewModel.editToolbarIcon)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(viewModel.isEditing ? AppDesign.elevated : AppDesign.accent, in: .circle)
            }
            .accessibilityLabel(viewModel.isEditing ? "Cancel edit mode" : "Edit counters")
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
