//
//  SecondaryView.swift
//  LabelBe
//

import SwiftUI

struct SecondaryView: View {
    @Environment(NavigationManager.self) private var navigation

    var body: some View {
        ZStack {
            if let screen = navigation.counterScreen {
                Group {
                    switch screen {
                    case .stats:
                        AppTodayStatsView()
                    case .weekComparison(let tag):
                        WeekComparisonDetailView(selectedTag: tag)
                    case .counter(let counter):
                        CounterDetailView(counter: counter)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppBackgroundView())
                .transition(screenTransition(for: screen))
                .zIndex(1)
            }
        }
        .allowsHitTesting(navigation.counterScreen != nil)
    }

    private func screenTransition(for screen: SecondaryScreensEnum) -> AnyTransition {
        switch screen {
        case .stats, .weekComparison:
            .move(edge: .bottom).combined(with: .opacity)
        case .counter:
            .move(edge: .bottom).combined(with: .opacity)
        }
    }
}

#Preview {
    SecondaryView()
        .environment(NavigationManager.shared)
}
