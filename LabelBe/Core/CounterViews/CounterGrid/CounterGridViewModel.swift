//
//  CounterGridViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class CounterGridViewModel {
    private let dataManager = SwiftDataManager.shared

    var sortFilter: CounterGridSortEnum = .valueHighToLow
    var selectedTag: String? = nil
    var isEditing = false
    var isShowingCreateSheet = false
    var selectedCounter: Counter? = nil
    private(set) var counters: [Counter] = []

    var allTags: [String] {
        counters.uniqueTags()
    }

    var filteredCounters: [Counter] {
        let filtered = counters.filter { matchesTag($0) }
        return sorted(filtered)
    }

    func refreshCounters() {
        counters = dataManager.fetchCounters()
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

    func deleteCounter() {
        guard let selectedCounter else { return }
        dataManager.deleteCounter(selectedCounter)
        self.selectedCounter = nil
        isEditing = false
        refreshCounters()
    }

    private func matchesTag(_ counter: Counter) -> Bool {
        guard let selectedTag else { return true }
        return counter.tags.contains(selectedTag)
    }

    private func sorted(_ counters: [Counter]) -> [Counter] {
        switch sortFilter {
        case .valueHighToLow:
            counters.sorted { $0.total > $1.total }
        case .valueLowToHigh:
            counters.sorted { $0.total < $1.total }
        case .nameAZ:
            counters.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        case .nameZA:
            counters.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedDescending
            }
        }
    }
}
