//
//  MainNavigationView.swift
//  LabelBe
//

import SwiftUI

struct MainNavigationView: View {
    @Environment(NavigationManager.self) private var navigation

    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                switch navigation.mainScreens {
                case .main:
                    MainView()
                case .profile:
                    ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomTabBar()
        }
        .allowsHitTesting(navigation.counterScreen == nil)
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        MainNavigationView()
    }
    .environment(NavigationManager.shared)
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
