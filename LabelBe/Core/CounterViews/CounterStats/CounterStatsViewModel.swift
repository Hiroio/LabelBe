//
//  CounterStatsViewModel.swift
//  LabelBe
//

import SwiftUI

@Observable
final class CounterStatsViewModel {
    let counter: Counter
  var currentMonth: Date = .now

    init(counter: Counter) {
        self.counter = counter
    }

    var todayBreakdown: EntryBreakdown {
        counter.todayEntryBreakdown
    }

    var monthBreakdown: EntryBreakdown {
        counter.currentMonthEntryBreakdown(date: currentMonth)
    }

    var last7Days: [DayTotal] {
        counter.dailyTotals(forLast: 7)
    }

    var currentMonthPeriods: [MonthPeriodTotal] {
        counter.monthPeriodTotals(forMonthContaining: currentMonth)
    }

    var accent: Color {
        AppDesign.cardAccent(for: counter.id)
    }
}
