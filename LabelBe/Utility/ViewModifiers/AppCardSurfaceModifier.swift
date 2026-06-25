//
//  AppCardSurfaceModifier.swift
//  LabelBe
//

import SwiftUI

struct AppCardSurfaceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: AppDesign.cardCornerRadius, style: .continuous)
                    .fill(AppDesign.card)
                    .shadow(color: AppDesign.cardShadowColor, radius: 10, y: 5)
            }
    }
}
