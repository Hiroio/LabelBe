//
//  CreateCounterViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class CreateCounterViewModel {
    var name = ""
    var selectedIcon = CounterIconCatalog.defaultIcon
    var tags: [String] = []

    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var canCreate: Bool {
        !trimmedName.isEmpty
    }

    func reset() {
        name = ""
        selectedIcon = CounterIconCatalog.defaultIcon
        tags = []
    }
}
