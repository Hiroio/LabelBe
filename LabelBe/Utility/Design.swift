//
//  Design.swift
//  LabelBe
//

import SwiftUI

enum AppDesign {
    // MARK: - Spacing

    static let screenPadding: CGFloat = 20
    static let gridSpacing: CGFloat = 14
    static let gridPadding: CGFloat = 20
    static let sectionSpacing: CGFloat = 24
    static let tabBarBottomPadding: CGFloat = 10
    static let tabBarHorizontalPadding: CGFloat = 28

    // MARK: - Layout

    static let cardCornerRadius: CGFloat = 22
    static let inputCornerRadius: CGFloat = 14
    static let cardMinHeight: CGFloat = 120
    static let iconBadgeSize: CGFloat = 52
    static let tabBarHeight: CGFloat = 62
    static let tabBarCornerRadius: CGFloat = 28
    static let profileAvatarSize: CGFloat = 72
    static let headerButtonSize: CGFloat = 40

    // MARK: - Colors

    static let accent = Color.indigo
    static let accentSecondary = Color.teal
    static let activeTabColor = accent
    static let inactiveTabColor = Color.secondary

    static let cardShadowColor = Color.black.opacity(0.07)
    static let tabBarShadowColor = Color.black.opacity(0.1)

    // MARK: - Animation

    static let quickAnimation: Animation = .snappy(duration: 0.22)
    static let tabAnimation: Animation = .smooth(duration: 0.28)

    // MARK: - Card accents

    private static let cardAccentPalette: [Color] = [
        .indigo, .teal, .orange, .pink, .mint, .purple, .cyan, .blue,
    ]

    static func cardAccent(for id: UUID) -> Color {
        let index = Int(id.uuid.0) % cardAccentPalette.count
        return cardAccentPalette[index]
    }

    static func cardGradient(for id: UUID) -> LinearGradient {
        let base = cardAccent(for: id)
        return LinearGradient(
            colors: [base.opacity(0.22), base.opacity(0.06)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
