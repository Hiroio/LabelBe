//
//  SoundManager.swift
//  LabelBe
//

import AudioToolbox
import Foundation

final class SoundManager {
    static let shared = SoundManager()

    private init() {}

    var isEnabled: Bool {
        ProfileSettingsStorage.bool(forKey: ProfileSettingsKey.soundsEnabled, default: true)
    }

    func playPlusSound() {
        guard isEnabled else { return }
        AudioServicesPlaySystemSound(1104)
    }

    func playMinusSound() {
        guard isEnabled else { return }
        AudioServicesPlaySystemSound(1057)
    }
}
