//
//  RootView.swift
//  LabelBe
//

import SwiftUI

struct RootView: View {
    @Environment(NavigationManager.self) private var navigation
    @AppStorage("OnBoarding") private var onBoardingState = false
    @State private var firstLaunch = true

    var body: some View {
        ZStack {
            AppBackgroundView()

            if firstLaunch {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            firstLaunch.toggle()
                        }
                    }
            } else if !onBoardingState {
                MainNavigationView()
                SecondaryView()
            } else {
                OnBoardingView()
            }
        }
        .animation(AppDesign.tabAnimation, value: navigation.counterScreen != nil)
        .animation(.easeInOut, value: onBoardingState)
        .animation(.easeInOut, value: firstLaunch)
    }
}

#Preview {
    RootView()
        .environment(NavigationManager.shared)
        .onAppear {
            PreviewSupport.configureIfNeeded()
        }
}
