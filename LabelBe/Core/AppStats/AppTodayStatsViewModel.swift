//
//  AppTodayStatsViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class AppTodayStatsViewModel {
    private let dataManager = SwiftDataManager.shared

    var currentMonth: Date = .now

    private var counters: [Counter] {
        dataManager.fetchCounters()
    }

    var monthPeriodTotals: [MonthPeriodTotal] {
        counters.monthPeriodTotals(forMonthContaining: currentMonth)
    }

    var todayRows: [CounterPeriodRow] {
        counters.todayRows()
    }
}
