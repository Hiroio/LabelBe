//
//  Counter+Stats.swift
//  LabelBe
//

import Foundation

extension Counter {
    func dailyTotals(forLast days: Int, calendar: Calendar = .current) -> [DayTotal] {
        let today = calendar.startOfDay(for: .now)

        return (0..<days).reversed().map { dayOffset in
            let date = calendar.date(byAdding: .day, value: -dayOffset, to: today) ?? today
            return DayTotal(date: date, total: total(on: date, calendar: calendar))
        }
    }

    func weekDailyTotals(calendar: Calendar = .current) -> [DayTotal] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: .now) else {
            return dailyTotals(forLast: 7, calendar: calendar)
        }

        var days: [DayTotal] = []
        var date = weekInterval.start

        while date < weekInterval.end {
            days.append(DayTotal(date: date, total: total(on: date, calendar: calendar)))
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = nextDate
        }

        return days
    }

    var currentWeekTotal: Int {
        weekDailyTotals().reduce(0) { $0 + $1.total }
    }

    var currentMonthEntryBreakdown: EntryBreakdown {
        entryBreakdown(forMonthContaining: .now)
    }

    func monthDailyTotals(calendar: Calendar = .current) -> [DayTotal] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: .now) else {
            return []
        }

        var days: [DayTotal] = []
        var date = monthInterval.start

        while date < monthInterval.end {
            days.append(DayTotal(date: date, total: total(on: date, calendar: calendar)))
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: date) else { break }
            date = nextDate
        }

        return days
    }

    func monthPeriodTotals(calendar: Calendar = .current) -> [MonthPeriodTotal] {
        MonthPeriodRanges.make(calendar: calendar).map { period in
            MonthPeriodTotal(
                id: period.id,
                label: period.label,
                total: total(fromDay: period.start, toDay: period.end, calendar: calendar),
                isCurrentPeriod: MonthPeriodRanges.isCurrentPeriod(
                    start: period.start,
                    end: period.end,
                    calendar: calendar
                )
            )
        }
    }

    func total(fromDay start: Int, toDay end: Int, calendar: Calendar = .current) -> Int {
        guard let monthInterval = calendar.dateInterval(of: .month, for: .now) else { return 0 }

        return entries.reduce(0) { result, entry in
            guard monthInterval.contains(entry.timestamp) else { return result }

            let day = calendar.component(.day, from: entry.timestamp)
            guard day >= start, day <= end else { return result }

            return result + entry.valueChange
        }
    }

    var todayEntryBreakdown: EntryBreakdown {
        entryBreakdown(on: .now)
    }

    var currentWeekEntryBreakdown: EntryBreakdown {
        entryBreakdown(forWeekContaining: .now)
    }

    func entryBreakdown(on date: Date, calendar: Calendar = .current) -> EntryBreakdown {
        let dayEntries = entries.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
        return breakdown(from: dayEntries)
    }

    func entryBreakdown(forWeekContaining date: Date, calendar: Calendar = .current) -> EntryBreakdown {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: date) else {
            return entryBreakdown(on: date, calendar: calendar)
        }

        let weekEntries = entries.filter { weekInterval.contains($0.timestamp) }
        return breakdown(from: weekEntries)
    }

    func entryBreakdown(forMonthContaining date: Date, calendar: Calendar = .current) -> EntryBreakdown {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return .empty
        }

        let monthEntries = entries.filter { monthInterval.contains($0.timestamp) }
        return breakdown(from: monthEntries)
    }

    private func breakdown(from entries: [CounterEntry]) -> EntryBreakdown {
        EntryBreakdown.from(entries: entries)
    }
}
