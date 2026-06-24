//
//  CounterStepButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct CounterStepButtonStyle: ButtonStyle {
    let accent: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .labelStyle(.iconOnly)
            .font(.title.weight(.semibold))
            .foregroundStyle(accent)
            .frame(width: 64, height: 64)
            .background(accent.opacity(configuration.isPressed ? 0.18 : 0.1), in: .circle)
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(AppDesign.quickAnimation, value: configuration.isPressed)
    }
}
