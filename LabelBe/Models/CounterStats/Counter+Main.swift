//
//  Counter+Main.swift
//  LabelBe
//

import Foundation

extension Counter {
    var lastInteractionDate: Date {
        entries.map(\.timestamp).max() ?? createdAt
    }
}

extension Array where Element == Counter {
    func sortedForDisplay() -> [Counter] {
        sorted { lhs, rhs in
            if lhs.isPinned != rhs.isPinned {
                return lhs.isPinned && !rhs.isPinned
            }
            return lhs.lastInteractionDate > rhs.lastInteractionDate
        }
    }

    func latestCounters(limit: Int = 2) -> [Counter] {
        sortedForDisplay()
            .prefix(limit)
            .map { $0 }
    }

    func topTodayRows(limit: Int = 3) -> [CounterPeriodRow] {
        todayRows()
            .prefix(limit)
            .map { $0 }
    }

    func todayRows() -> [CounterPeriodRow] {
        map { CounterPeriodRow(counter: $0, periodDelta: $0.todayTotal) }
            .filter { $0.periodDelta > 0 }
            .sorted { $0.periodDelta > $1.periodDelta }
    }

    func uniqueTags() -> [String] {
        var result = Set<String>()
        for counter in self {
            for tag in counter.tags {
                result.insert(tag)
            }
        }
        return result.sorted { $0.lowercased() < $1.lowercased() }
    }

    func filtered(byTag tag: String?) -> [Counter] {
        guard let tag else { return self }
        return filter { $0.tags.contains(tag) }
    }
}
