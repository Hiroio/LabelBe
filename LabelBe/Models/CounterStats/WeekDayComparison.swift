//
//  WeekDayComparison.swift
//  LabelBe
//

import Foundation

struct WeekDayComparison: Identifiable {
    let label: String
    let currentTotal: Int
    let previousTotal: Int

    var id: String { label }
}

struct WeekChartPoint: Identifiable {
    let id: String
    let day: String
    let period: String
    let total: Int
}
