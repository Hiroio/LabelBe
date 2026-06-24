//
//  ThirdOnBoardingView.swift
//  LabelBe
//

import SwiftUI

struct ThirdOnBoardingView: View {
    @AppStorage(ProfileSettingsKey.soundsEnabled) private var soundsEnabled = true
    @AppStorage(ProfileSettingsKey.notificationsEnabled) private var notificationsEnabled = false

    var body: some View {
        VStack(spacing: 0) {
            pageHeader(
                title: "Personalize LabelBe",
                description: "Choose sounds for tap feedback and notifications to stay on track."
            )

            Spacer()

            settingsCard

            Spacer()
        }
		  .onChange(of: notificationsEnabled) { _, _ in
			 NotificationManager.shared.initialize()
		  }
    }
}

extension ThirdOnBoardingView {
    private func pageHeader(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, 32)
    }

    private var settingsCard: some View {
        VStack(spacing: 0) {
            Toggle("Sounds", isOn: $soundsEnabled)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)

            Divider()
                .padding(.leading, 18)

            Toggle("Notifications", isOn: $notificationsEnabled)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
        }
        .appCardSurface()
        .padding(.horizontal, AppDesign.screenPadding)
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        ThirdOnBoardingView()
    }
}
