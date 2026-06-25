//
//  Design.swift
//  LabelBe
//

import SwiftUI

enum AppDesign {
    // MARK: - Spacing

    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24

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

    static let background = Color(red: 0.09, green: 0.10, blue: 0.09)
    static let card = Color(red: 0.14, green: 0.15, blue: 0.14)
    static let elevated = Color(red: 0.18, green: 0.19, blue: 0.18)

    static let primaryText = Color(red: 0.94, green: 0.95, blue: 0.94)
    static let secondaryText = Color(red: 0.62, green: 0.65, blue: 0.63)

    static let accent = Color(red: 0.42, green: 0.56, blue: 0.44)
    static let accentSecondary = Color(red: 0.32, green: 0.48, blue: 0.36)
    static let accentMuted = Color(red: 0.42, green: 0.56, blue: 0.44).opacity(0.22)

    static let activeTabColor = accent
    static let inactiveTabColor = secondaryText

    static let cardShadowColor = Color.black.opacity(0.28)
    static let tabBarShadowColor = Color.black.opacity(0.35)

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

    static func cardAccentMuted(for id: UUID) -> Color {
        cardAccent(for: id).opacity(0.22)
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
