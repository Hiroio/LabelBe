//
//  AccentIconBadgeModifier.swift
//  LabelBe
//

import SwiftUI

struct AccentIconBadgeModifier: ViewModifier {
    let color: Color
    let size: CGFloat

    func body(content: Content) -> some View {
        content
            .frame(width: size, height: size)
            .background(color.opacity(0.12), in: .circle)
    }
}
