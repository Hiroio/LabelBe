//
//  FloatingTabBarModifier.swift
//  LabelBe
//

import SwiftUI

struct FloatingTabBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(6)
            .frame(height: AppDesign.tabBarHeight)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: AppDesign.tabBarCornerRadius))
            .overlay {
                RoundedRectangle(cornerRadius: AppDesign.tabBarCornerRadius, style: .continuous)
                    .strokeBorder(.white.opacity(0.45), lineWidth: 1)
            }
            .shadow(color: AppDesign.tabBarShadowColor, radius: 16, y: 6)
            .padding(.horizontal, AppDesign.tabBarHorizontalPadding)
            .padding(.bottom, AppDesign.tabBarBottomPadding)
    }
}
