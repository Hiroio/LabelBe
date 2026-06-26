//
//  WeekComparison.swift
//  LabelBe
//

import Foundation

struct WeekComparison {
    let currentWeekTotal: Int
    let previousWeekTotal: Int

    var delta: Int {
        currentWeekTotal - previousWeekTotal
    }

    var deltaText: String {
        if delta > 0 { return "+\(delta)" }
        if delta < 0 { return "\(delta)" }
        return "0"
    }
}
