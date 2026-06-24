//
//  ProfileSettingsKey.swift
//  LabelBe
//

import Foundation

enum ProfileSettingsKey {
    static let soundsEnabled = "profile.soundsEnabled"
    static let notificationsEnabled = "profile.notificationsEnabled"
}

enum ProfileSettingsStorage {
    static func bool(forKey key: String, default defaultValue: Bool) -> Bool {
        guard UserDefaults.standard.object(forKey: key) != nil else {
            return defaultValue
        }
        return UserDefaults.standard.bool(forKey: key)
    }

    static func set(_ value: Bool, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}
