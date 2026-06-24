//
//  EmptyStateAddButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct EmptyStateAddButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title.weight(.semibold))
            .fontDesign(.rounded)
            .foregroundStyle(AppDesign.accent)
            .padding()
            .background(Circle().fill(AppDesign.accentSecondary.opacity(configuration.isPressed ? 0.28 : 0.2)))
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(AppDesign.quickAnimation, value: configuration.isPressed)
    }
}
