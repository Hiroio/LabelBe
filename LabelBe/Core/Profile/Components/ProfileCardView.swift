//
//  ProfileCardView.swift
//  LabelBe
//

import SwiftUI

struct ProfileCardView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: AppDesign.profileAvatarSize * 0.55))
                .foregroundStyle(AppDesign.accent)
                .accentIconBadge(color: AppDesign.accent, size: AppDesign.profileAvatarSize)

            VStack(alignment: .leading, spacing: 4) {
                Text("Local Profile")
                    .font(.headline)

                Text("All data stays on this device.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)
        }
        .padding(18)
        .appCardSurface()
    }
}

#Preview {
    ProfileCardView()
        .padding()
}
