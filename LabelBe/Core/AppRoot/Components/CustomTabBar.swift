//
//  CustomTabBar.swift
//  LabelBe
//

import SwiftUI

struct CustomTabBar: View {
    @Environment(NavigationManager.self) private var navigation

    var body: some View {
        HStack(spacing: 8) {
            TabBarButton(
                icon: "house",
                activeIcon: "house.fill",
                label: "Home",
                isActive: navigation.mainScreens == .main
            ) {
                selectTab(.main)
            }

            TabBarButton(
                icon: "rectangle.grid.2x2",
                activeIcon: "rectangle.grid.2x2.fill",
                label: "Grid",
                isActive: navigation.mainScreens == .grid
            ) {
                selectTab(.grid)
            }

            TabBarButton(
                icon: "person",
                activeIcon: "person.fill",
                label: "Profile",
                isActive: navigation.mainScreens == .profile
            ) {
                selectTab(.profile)
            }
        }
        .floatingTabBarChrome()
    }

    private func selectTab(_ screen: MainScreensEnum) {
        withAnimation(AppDesign.tabAnimation) {
            navigation.mainScreens = screen
        }
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBar()
    }
    .background(AppBackgroundView())
    .environment(NavigationManager.shared)
}
