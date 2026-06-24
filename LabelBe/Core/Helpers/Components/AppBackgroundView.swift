//
//  AppBackgroundView.swift
//  LabelBe
//

import SwiftUI

struct AppBackgroundView: View {
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            RadialGradient(
                colors: [
                    AppDesign.accent.opacity(0.16),
                    AppDesign.accentSecondary.opacity(0.08),
                    .clear,
                ],
                center: .topLeading,
                startRadius: 40,
                endRadius: 420
            )
            .ignoresSafeArea()

            RadialGradient(
                colors: [
                    AppDesign.accentSecondary.opacity(0.1),
                    .clear,
                ],
                center: .bottomTrailing,
                startRadius: 20,
                endRadius: 360
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    AppBackgroundView()
}
