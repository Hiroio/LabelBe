//
//  CounterDetailViewModel.swift
//  LabelBe
//

import SwiftUI

@Observable
final class CounterDetailViewModel {
    private let dataManager = SwiftDataManager.shared
    private let soundManager = SoundManager.shared

    let counter: Counter
    var selectedTab: CounterDetailTab = .counter

    private(set) var refreshID = UUID()

    init(counter: Counter) {
        self.counter = counter
    }

    var todayTotal: Int {
        counter.todayTotal
    }

    var total: Int {
        counter.total
    }

    var accent: Color {
        AppDesign.cardAccent(for: counter.id)
    }

    var isPinned: Bool {
        counter.isPinned
    }

    var tags: [String] {
        counter.tags
    }

    func recordTap(value: Int) {
        guard value == 1 || value == -1 else { return }

        dataManager.addEntry(to: counter, value: value)

        if value == 1 {
            soundManager.playPlusSound()
        } else {
            soundManager.playMinusSound()
        }

        refreshID = UUID()
    }

    func togglePin() {
        dataManager.setPinned(counter, isPinned: !counter.isPinned)
        refreshID = UUID()
    }

    func saveChanges(name: String, icon: String, tags: [String]) {
        dataManager.updateCounter(counter, name: name, icon: icon, tags: tags)
        refreshID = UUID()
    }
}
