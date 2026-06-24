//
//  HeaderCloseButtonModifier.swift
//  LabelBe
//

import SwiftUI

struct HeaderCloseButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelStyle(.iconOnly)
            .buttonStyle(.plain)
            .frame(width: AppDesign.headerButtonSize, height: AppDesign.headerButtonSize)
            .background(.ultraThinMaterial, in: .circle)
            .foregroundStyle(.primary)
    }
}
