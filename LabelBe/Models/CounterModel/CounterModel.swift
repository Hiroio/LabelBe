//
//  CounterModel.swift
//  LabelBe
//

import Foundation
import SwiftData

@Model
final class Counter {
    var id: UUID
    var name: String
    var icon: String
    var tags: [String]
    var createdAt: Date
    var isPinned: Bool
    var isArchived: Bool

    @Relationship(deleteRule: .cascade, inverse: \CounterEntry.counter)
    var entries: [CounterEntry]

    init(name: String, icon: String, tags: [String] = []) {
        id = UUID()
        self.name = name
        self.icon = icon
        self.tags = tags
        createdAt = .now
        isPinned = false
        isArchived = false
        entries = []
    }

    var total: Int {
        entries.reduce(0) { $0 + $1.valueChange }
    }

    var todayTotal: Int {
        total(on: .now)
    }

    func total(on date: Date, calendar: Calendar = .current) -> Int {
        entries.reduce(0) { result, entry in
            calendar.isDate(entry.timestamp, inSameDayAs: date)
                ? result + entry.valueChange
                : result
        }
    }
}

@Model
final class CounterEntry {
    var id: UUID
    var timestamp: Date
    var valueChange: Int
    var counter: Counter?

    init(valueChange: Int, timestamp: Date = .now) {
        id = UUID()
        self.timestamp = timestamp
        self.valueChange = valueChange
    }
}
