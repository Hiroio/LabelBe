//
//  CounterCardButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct CounterCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(AppDesign.quickAnimation, value: configuration.isPressed)
    }
}
