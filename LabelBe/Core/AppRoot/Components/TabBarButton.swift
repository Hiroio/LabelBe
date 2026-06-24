//
//  TabBarButton.swift
//  LabelBe
//

import SwiftUI

struct TabBarButton: View {
    let icon: String
    let activeIcon: String
    let label: String
    let isActive: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isActive ? activeIcon : icon)
                .font(.title3)
                .frame(maxWidth: .infinity, minHeight: 44)
                .foregroundStyle(isActive ? AppDesign.activeTabColor : AppDesign.inactiveTabColor)
                .background {
                    if isActive {
                        Capsule()
                            .fill(AppDesign.accent.opacity(0.14))
                    }
                }
        }
        .buttonStyle(PlainIconButtonStyle())
        .accessibilityLabel(label)
    }
}

#Preview {
    HStack {
        TabBarButton(icon: "house", activeIcon: "house.fill", label: "Counters", isActive: true, action: {})
        TabBarButton(icon: "person", activeIcon: "person.fill", label: "Profile", isActive: false, action: {})
    }
    .padding()
}
