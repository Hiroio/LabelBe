//
//  CounterGridSortEnum.swift
//  LabelBe
//

import Foundation

enum CounterGridSortEnum: String, CaseIterable, Identifiable {
    case valueHighToLow
    case valueLowToHigh
    case nameAZ
    case nameZA

    var id: String { rawValue }

    var title: String {
        switch self {
        case .valueHighToLow:
            "Highest to lowest"
        case .valueLowToHigh:
            "Lowest to highest"
        case .nameAZ:
            "A to Z"
        case .nameZA:
            "Z to A"
        }
    }
}
