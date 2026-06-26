//
//  CounterGridViewModel.swift
//  LabelBe
//

import Foundation

enum CounterGridAction: Equatable {
    case archive
    case delete
}

enum CounterGridContent: Equatable {
    case createEmpty
    case archivedEmpty
    case noResults
    case grid
}

@Observable
final class CounterGridViewModel {
    private let dataManager = SwiftDataManager.shared

    var sortFilter: CounterGridSortEnum = .valueHighToLow
    var selectedTag: String? = nil
    var searchText = ""
    var showsArchived = false
    var isEditing = false
    var isShowingCreateSheet = false
    var selectedCounter: Counter? = nil
    var pendingAction: CounterGridAction? = nil
    private(set) var counters: [Counter] = []

    var allTags: [String] {
        counters.uniqueTags()
    }

    var displayedCounters: [Counter] {
        sorted(
            counters.filter { matchesSearch($0) && matchesTag($0) }
        )
    }

    var gridContent: CounterGridContent {
        if counters.isEmpty {
            return showsArchived ? .archivedEmpty : .createEmpty
        }
        if displayedCounters.isEmpty {
            return .noResults
        }
        return .grid
    }

    var showsSearchFilters: Bool {
        !showsArchived
    }

    var headerTitle: String {
        showsArchived ? "Archived" : "Counters"
    }

    var editToolbarIcon: String {
        if isEditing { return "xmark" }
        return showsArchived ? "trash" : "archivebox"
    }

    var editCellIcon: String {
        showsArchived ? "trash.fill" : "archivebox.fill"
    }

    var showsRestoreInEdit: Bool {
        showsArchived && isEditing
    }

    func refreshCounters() {
        counters = showsArchived
            ? dataManager.fetchArchivedCounters()
            : dataManager.fetchActiveCounters()
    }

    func toggleArchivedView() {
        showsArchived.toggle()
        isEditing = false
        selectedCounter = nil
        pendingAction = nil
        refreshCounters()
    }

    func openCreation() {
        isShowingCreateSheet = true
    }

    func createCounter(name: String, icon: String, tags: [String]) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        dataManager.addCounter(name: trimmed, icon: icon, tags: tags)
        refreshCounters()
        isShowingCreateSheet = false
    }

    func handleEditTap(on counter: Counter) {
        selectedCounter = counter
        pendingAction = showsArchived ? .delete : .archive
    }

    func confirmAction() {
        guard let selectedCounter else { return }

        switch pendingAction {
        case .archive:
            dataManager.archiveCounter(selectedCounter)
        case .delete:
            dataManager.deleteCounter(selectedCounter)
        case .none:
            break
        }

        self.selectedCounter = nil
        self.pendingAction = nil
        isEditing = false
        refreshCounters()
    }

    func cancelPendingAction() {
        selectedCounter = nil
        pendingAction = nil
    }

    func restoreCounter(_ counter: Counter) {
        dataManager.restoreCounter(counter)
        refreshCounters()
    }

    func toggleEditing() {
        isEditing.toggle()
        if !isEditing {
            cancelPendingAction()
        }
    }

    private func matchesSearch(_ counter: Counter) -> Bool {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return true }

        if counter.name.localizedCaseInsensitiveContains(query) {
            return true
        }

        return counter.tags.contains { $0.localizedCaseInsensitiveContains(query) }
    }

    private func matchesTag(_ counter: Counter) -> Bool {
        guard let selectedTag else { return true }
        return counter.tags.contains(selectedTag)
    }

    private func sorted(_ counters: [Counter]) -> [Counter] {
        switch sortFilter {
        case .valueHighToLow:
            counters.sorted { lhs, rhs in
                if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
                return lhs.total > rhs.total
            }
        case .valueLowToHigh:
            counters.sorted { lhs, rhs in
                if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
                return lhs.total < rhs.total
            }
        case .nameAZ:
            counters.sorted { lhs, rhs in
                if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
                return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
            }
        case .nameZA:
            counters.sorted { lhs, rhs in
                if lhs.isPinned != rhs.isPinned { return lhs.isPinned && !rhs.isPinned }
                return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedDescending
            }
        }
    }
}
