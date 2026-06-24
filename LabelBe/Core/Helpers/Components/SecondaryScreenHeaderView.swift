//
//  SecondaryScreenHeaderView.swift
//  LabelBe
//

import SwiftUI

struct SecondaryScreenHeaderView: View {
    let title: String
    let onClose: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button("Close", systemImage: "xmark", action: onClose)
                .headerCloseButton()

            Spacer()

            Text(title)
                .font(.title2)
                .bold()
                .lineLimit(1)

            Spacer()

            Color.clear
                .frame(width: AppDesign.headerButtonSize, height: AppDesign.headerButtonSize)
                .accessibilityHidden(true)
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}

#Preview {
    SecondaryScreenHeaderView(title: "New Counter", onClose: {})
        .background(AppBackgroundView())
}
