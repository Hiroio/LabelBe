//
//  CounterPeriodRow.swift
//  LabelBe
//

import Foundation

struct CounterPeriodRow: Identifiable {
    let counter: Counter
    let periodDelta: Int

    var id: UUID {
        counter.id
    }
}
