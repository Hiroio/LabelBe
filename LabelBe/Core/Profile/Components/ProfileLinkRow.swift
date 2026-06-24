//
//  ProfileLinkRow.swift
//  LabelBe
//

import SwiftUI

struct ProfileLinkRow: View {
    let title: String
    let icon: String
    let destination: URL

    var body: some View {
        Link(destination: destination) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundStyle(AppDesign.accent)
                    .frame(width: 28)

                Text(title)
                    .font(.body)
                    .foregroundStyle(.primary)

                Spacer()

                Image(systemName: "arrow.up.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .contentShape(.rect)
        }
    }
}

#Preview {
    ProfileLinkRow(
        title: "Privacy Policy",
        icon: "hand.raised.fill",
        destination: URL(string: "https://example.com")!
    )
}
