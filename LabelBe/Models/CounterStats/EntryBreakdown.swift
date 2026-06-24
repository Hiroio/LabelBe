//
//  EntryBreakdown.swift
//  LabelBe
//

import Foundation

struct EntryBreakdown {
    let pluses: Int
    let minuses: Int
    let total: Int

    static func from(entries: [CounterEntry]) -> EntryBreakdown {
        EntryBreakdown(
            pluses: entries.count(where: { $0.valueChange == 1 }),
            minuses: entries.count(where: { $0.valueChange == -1 }),
            total: entries.reduce(0) { $0 + $1.valueChange }
        )
    }

    static let empty = EntryBreakdown(pluses: 0, minuses: 0, total: 0)
}
