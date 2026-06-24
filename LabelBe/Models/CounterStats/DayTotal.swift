//
//  DayTotal.swift
//  LabelBe
//

import Foundation

struct DayTotal: Identifiable {
    let date: Date
    let total: Int

    var id: Date { date }

    var shortWeekday: String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }

    var dayNumber: String {
        date.formatted(.dateTime.day())
    }

    var dayOfMonth: Int {
        Calendar.current.component(.day, from: date)
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}
