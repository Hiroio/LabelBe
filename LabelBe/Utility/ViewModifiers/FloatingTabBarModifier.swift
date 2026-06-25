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
            .background(AppDesign.card, in: .rect(cornerRadius: AppDesign.tabBarCornerRadius))
            .shadow(color: AppDesign.tabBarShadowColor, radius: 16, y: 6)
            .padding(.horizontal, AppDesign.tabBarHorizontalPadding)
            .padding(.bottom, AppDesign.tabBarBottomPadding)
    }
}
