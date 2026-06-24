//
//  CounterStatsViewModel.swift
//  LabelBe
//

import SwiftUI

@Observable
final class CounterStatsViewModel {
    let counter: Counter

    init(counter: Counter) {
        self.counter = counter
    }

    var todayBreakdown: EntryBreakdown {
        counter.todayEntryBreakdown
    }

    var monthBreakdown: EntryBreakdown {
        counter.currentMonthEntryBreakdown
    }

    var last7Days: [DayTotal] {
        counter.dailyTotals(forLast: 7)
    }

    var currentMonthPeriods: [MonthPeriodTotal] {
        counter.monthPeriodTotals()
    }

    var accent: Color {
        AppDesign.cardAccent(for: counter.id)
    }
}
