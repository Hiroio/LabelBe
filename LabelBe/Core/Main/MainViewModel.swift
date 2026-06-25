//
//  MainViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class MainViewModel {
    private let dataManager = SwiftDataManager.shared

    private(set) var counters: [Counter] = []

    var latestCounters: [Counter] {
        counters.latestCounters(limit: 2)
    }

    var topTodayRows: [CounterPeriodRow] {
        counters.topTodayRows(limit: 3)
    }

    var currentMonthPeriods: [MonthPeriodTotal] {
        counters.monthPeriodTotals(forMonthContaining: .now)
    }

    func refreshCounters() {
        counters = dataManager.fetchCounters()
    }

    func createCounter(name: String, icon: String, tags: [String]) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        dataManager.addCounter(name: trimmed, icon: icon, tags: tags)
        refreshCounters()
    }
}
