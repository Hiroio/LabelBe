//
//  IconPickerButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct IconPickerButtonStyle: ButtonStyle {
    let isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body)
            .frame(width: 44, height: 44)
            .foregroundStyle(isSelected ? AppDesign.accent : .secondary)
            .background {
                if isSelected {
                    Circle()
                        .fill(AppDesign.accent.opacity(0.12))
                }
            }
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
