//
//  MonthPeriodTotal.swift
//  LabelBe
//

import Foundation

struct MonthPeriodTotal: Identifiable {
    let id: Int
    let label: String
    let total: Int
    let isCurrentPeriod: Bool
}

enum MonthPeriodRanges {
    struct Period {
        let id: Int
        let start: Int
        let end: Int

        var label: String {
            start == 29 ? "29-\(end)" : "\(start)-\(end)"
        }
    }

    static func make(for date: Date = .now, calendar: Calendar = .current) -> [Period] {
        let daysInMonth = calendar.range(of: .day, in: .month, for: date)?.count ?? 30

        let ranges: [(Int, Int)] = [
            (1, 7),
            (8, 14),
            (15, 21),
            (22, 28),
            (29, daysInMonth),
        ]

        return ranges.enumerated().map { index, range in
            Period(id: index, start: range.0, end: range.1)
        }
    }

    static func isCurrentPeriod(
        start: Int,
        end: Int,
        inMonthContaining month: Date,
        calendar: Calendar = .current
    ) -> Bool {
        guard calendar.isDate(month, equalTo: .now, toGranularity: .month) else { return false }

        let today = calendar.component(.day, from: .now)
        return today >= start && today <= end
    }
}
