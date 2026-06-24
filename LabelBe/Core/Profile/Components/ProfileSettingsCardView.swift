//
//  ProfileSettingsCardView.swift
//  LabelBe
//

import SwiftUI

struct ProfileSettingsCardView: View {
    let privacyPolicyURL: URL
    let termsOfUseURL: URL

    var body: some View {
        VStack(spacing: 0) {
            ProfileLinkRow(
                title: "Privacy Policy",
                icon: "hand.raised.fill",
                destination: privacyPolicyURL
            )

            Divider()
                .padding(.leading, 52)

            ProfileLinkRow(
                title: "Terms of Use",
                icon: "doc.text.fill",
                destination: termsOfUseURL
            )
        }
        .appCardSurface()
    }
}

#Preview {
    ProfileSettingsCardView(
        privacyPolicyURL: URL(string: "https://example.com/privacy")!,
        termsOfUseURL: URL(string: "https://example.com/terms")!
    )
    .padding()
}
