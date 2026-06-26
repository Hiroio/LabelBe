//
//  AppTodayStatsViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class AppTodayStatsViewModel {
    private let dataManager = SwiftDataManager.shared

    var currentMonth: Date = .now
    var selectedTag: String? = nil

    private var counters: [Counter] {
        dataManager.fetchActiveCounters()
    }

    private var filteredCounters: [Counter] {
        counters.filtered(byTag: selectedTag)
    }

    var allTags: [String] {
        counters.uniqueTags()
    }

    var monthPeriodTotals: [MonthPeriodTotal] {
        filteredCounters.monthPeriodTotals(forMonthContaining: currentMonth)
    }

    var todayRows: [CounterPeriodRow] {
        filteredCounters.todayRows()
    }

    var weekComparison: WeekComparison {
        filteredCounters.weekComparison()
    }
}
