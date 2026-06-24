//
//  AccentProminentButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct AccentProminentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .foregroundStyle(.white)
            .background(AppDesign.accent.opacity(configuration.isPressed ? 0.85 : 1), in: Capsule())
    }
}
