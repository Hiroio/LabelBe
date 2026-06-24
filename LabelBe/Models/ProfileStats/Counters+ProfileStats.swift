//
//  Counters+ProfileStats.swift
//  LabelBe
//

import Foundation

extension Array where Element == Counter {
    var currentMonthEntryBreakdown: EntryBreakdown {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: .now) else {
            return .empty
        }

        let entries = flatMap(\.entries).filter { monthInterval.contains($0.timestamp) }
        return EntryBreakdown.from(entries: entries)
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

        return flatMap(\.entries).reduce(0) { result, entry in
            guard monthInterval.contains(entry.timestamp) else { return result }

            let day = calendar.component(.day, from: entry.timestamp)
            guard day >= start, day <= end else { return result }

            return result + entry.valueChange
        }
    }
}
