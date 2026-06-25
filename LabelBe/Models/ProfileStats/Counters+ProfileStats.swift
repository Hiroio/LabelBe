//
//  Counters+ProfileStats.swift
//  LabelBe
//

import Foundation

extension Array where Element == Counter {
    var currentMonthEntryBreakdown: EntryBreakdown {
        currentMonthEntryBreakdown(forMonthContaining: .now)
    }

    func currentMonthEntryBreakdown(forMonthContaining date: Date, calendar: Calendar = .current) -> EntryBreakdown {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else {
            return .empty
        }

        let entries = flatMap(\.entries).filter { monthInterval.contains($0.timestamp) }
        return EntryBreakdown.from(entries: entries)
    }

    func monthPeriodTotals(forMonthContaining date: Date, calendar: Calendar = .current) -> [MonthPeriodTotal] {
        MonthPeriodRanges.make(for: date, calendar: calendar).map { period in
            MonthPeriodTotal(
                id: period.id,
                label: period.label,
                total: total(
                    fromDay: period.start,
                    toDay: period.end,
                    inMonthContaining: date,
                    calendar: calendar
                ),
                isCurrentPeriod: MonthPeriodRanges.isCurrentPeriod(
                    start: period.start,
                    end: period.end,
                    inMonthContaining: date,
                    calendar: calendar
                )
            )
        }
    }

    func total(
        fromDay start: Int,
        toDay end: Int,
        inMonthContaining date: Date,
        calendar: Calendar = .current
    ) -> Int {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date) else { return 0 }

        return flatMap(\.entries).reduce(0) { result, entry in
            guard monthInterval.contains(entry.timestamp) else { return result }

            let day = calendar.component(.day, from: entry.timestamp)
            guard day >= start, day <= end else { return result }

            return result + entry.valueChange
        }
    }
}
