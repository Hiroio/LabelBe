//
//  ProfileViewModel.swift
//  LabelBe
//

import SwiftUI

@Observable
final class ProfileViewModel {
    private let dataManager = SwiftDataManager.shared

    private(set) var counters: [Counter] = []

    var soundsEnabled: Bool {
        didSet {
            ProfileSettingsStorage.set(soundsEnabled, forKey: ProfileSettingsKey.soundsEnabled)
        }
    }

    var notificationsEnabled: Bool {
        didSet {
            ProfileSettingsStorage.set(notificationsEnabled, forKey: ProfileSettingsKey.notificationsEnabled)
        }
    }

    init() {
        soundsEnabled = ProfileSettingsStorage.bool(forKey: ProfileSettingsKey.soundsEnabled, default: true)
        notificationsEnabled = ProfileSettingsStorage.bool(
            forKey: ProfileSettingsKey.notificationsEnabled,
            default: false
        )
    }

    var currentMonthBreakdown: EntryBreakdown {
        counters.currentMonthEntryBreakdown
    }

    func refresh() {
        counters = dataManager.fetchCounters()
    }
}
