//
//  AccentCircleButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct AccentCircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.iconOnly)
            .font(.body.weight(.semibold))
            .foregroundStyle(.white)
            .padding(10)
            .background(AppDesign.accent.opacity(configuration.isPressed ? 0.85 : 1), in: Circle())
    }
}
