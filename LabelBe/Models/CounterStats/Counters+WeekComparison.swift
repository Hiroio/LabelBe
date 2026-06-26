//
//  Counters+WeekComparison.swift
//  LabelBe
//

import Foundation

extension Array where Element == Counter {
    func weekComparison(calendar: Calendar = .current) -> WeekComparison {
        let current = reduce(0) { $0 + $1.weekTotal(containing: .now, calendar: calendar) }
        let previousDate = calendar.date(byAdding: .weekOfYear, value: -1, to: .now) ?? .now
        let previous = reduce(0) { $0 + $1.weekTotal(containing: previousDate, calendar: calendar) }
        return WeekComparison(currentWeekTotal: current, previousWeekTotal: previous)
    }

    var todayEntryBreakdown: EntryBreakdown {
        EntryBreakdown.from(entries: flatMap(\.entries).filter {
            Calendar.current.isDate($0.timestamp, inSameDayAs: .now)
        })
    }

    func weekDayComparisons(calendar: Calendar = .current) -> [WeekDayComparison] {
        guard let currentWeek = calendar.dateInterval(of: .weekOfYear, for: .now),
              let previousWeekStart = calendar.date(byAdding: .weekOfYear, value: -1, to: currentWeek.start)
        else { return [] }

        return (0..<7).compactMap { offset in
            guard let currentDay = calendar.date(byAdding: .day, value: offset, to: currentWeek.start),
                  let previousDay = calendar.date(byAdding: .day, value: offset, to: previousWeekStart)
            else { return nil }

            let currentTotal = reduce(0) { $0 + $1.total(on: currentDay, calendar: calendar) }
            let previousTotal = reduce(0) { $0 + $1.total(on: previousDay, calendar: calendar) }

            return WeekDayComparison(
                label: currentDay.formatted(.dateTime.weekday(.abbreviated)),
                currentTotal: currentTotal,
                previousTotal: previousTotal
            )
        }
    }

    func weekChartPoints(calendar: Calendar = .current) -> [WeekChartPoint] {
        weekDayComparisons(calendar: calendar).flatMap { row in
            [
                WeekChartPoint(
                    id: "\(row.label)-current",
                    day: row.label,
                    period: "This Week",
                    total: row.currentTotal
                ),
                WeekChartPoint(
                    id: "\(row.label)-previous",
                    day: row.label,
                    period: "Last Week",
                    total: row.previousTotal
                ),
            ]
        }
    }
}

extension Counter {
    func weekTotal(containing date: Date, calendar: Calendar = .current) -> Int {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: date) else { return 0 }

        return entries.reduce(0) { result, entry in
            weekInterval.contains(entry.timestamp) ? result + entry.valueChange : result
        }
    }
}
