//
//  ProfileSettingsTogglesCard.swift
//  LabelBe
//

import SwiftUI

struct ProfileSettingsTogglesCard: View {
    @Bindable var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: 0) {
            Toggle("Sounds", isOn: $viewModel.soundsEnabled)
                .tint(AppDesign.accent)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)

            Divider()
                .padding(.leading, 18)

            Toggle("Notifications", isOn: $viewModel.notificationsEnabled)
                .tint(AppDesign.accent)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
        }
        .appCardSurface()
    }
}

#Preview {
    ProfileSettingsTogglesCard(viewModel: ProfileViewModel())
        .padding()
        .onAppear {
            PreviewSupport.configureIfNeeded()
        }
}
