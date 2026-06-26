//
//  Counter+Streak.swift
//  LabelBe
//

import Foundation

extension Counter {
    func currentStreak(calendar: Calendar = .current) -> Int {
        var streak = 0
        var date = calendar.startOfDay(for: .now)

        if !hasActivity(on: date, calendar: calendar) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: date) else { return 0 }
            guard hasActivity(on: yesterday, calendar: calendar) else { return 0 }
            date = yesterday
        }

        while hasActivity(on: date, calendar: calendar) {
            streak += 1
            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: date) else { break }
            date = previousDay
        }

        return streak
    }

    private func hasActivity(on date: Date, calendar: Calendar) -> Bool {
        entries.contains { calendar.isDate($0.timestamp, inSameDayAs: date) }
    }
}
