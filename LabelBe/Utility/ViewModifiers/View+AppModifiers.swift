//
//  View+AppModifiers.swift
//  LabelBe
//

import SwiftUI

extension View {
    func appCardSurface() -> some View {
        modifier(AppCardSurfaceModifier())
    }

    func counterCardSurface() -> some View {
        modifier(CounterCardSurfaceModifier())
    }

    func inputFieldSurface() -> some View {
        modifier(InputFieldSurfaceModifier())
    }

    func floatingTabBarChrome() -> some View {
        modifier(FloatingTabBarModifier())
    }

    func accentIconBadge(color: Color, size: CGFloat) -> some View {
        modifier(AccentIconBadgeModifier(color: color, size: size))
    }

    func headerCloseButton() -> some View {
        modifier(HeaderCloseButtonModifier())
    }
}
