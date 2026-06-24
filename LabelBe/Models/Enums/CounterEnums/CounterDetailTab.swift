//
//  CounterDetailTab.swift
//  LabelBe
//

import Foundation

enum CounterDetailTab: String, CaseIterable, Identifiable {
    case counter
    case stats

    var id: String { rawValue }

    var title: String {
        switch self {
        case .counter: "Counter"
        case .stats: "Stats"
        }
    }
}
