//
//  CounterCardSurfaceModifier.swift
//  LabelBe
//

import SwiftUI

struct CounterCardSurfaceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppDesign.card, in: .rect(cornerRadius: AppDesign.cardCornerRadius))
            .shadow(color: AppDesign.cardShadowColor, radius: 6, y: 3)
    }
}
