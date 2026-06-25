//
//  AppTodayStatsView.swift
//  LabelBe
//

import SwiftUI

struct AppTodayStatsView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel = AppTodayStatsViewModel()

    var body: some View {
        VStack(spacing: 0) {
            SecondaryScreenHeaderView(title: "Stats", onClose: dismiss)

            ScrollView {
                VStack(spacing: AppDesign.sectionSpacing) {
                    CounterStatsMonthCard(
                        currentMonth: $viewModel.currentMonth,
                        chartData: viewModel.monthPeriodTotals,
                        accent: AppDesign.accent
                    )

                    AppTodayActivityCard(rows: viewModel.todayRows)
                }
                .padding(.horizontal, AppDesign.screenPadding)
                .padding(.vertical, AppDesign.spacingM)
                .padding(.bottom, AppDesign.tabBarHeight)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background { AppBackgroundView() }
    }

    private func dismiss() {
        navigation.counterScreen = nil
    }
}

#Preview {
    AppTodayStatsView()
        .environment(NavigationManager.shared)
        .onAppear {
            PreviewSupport.configureIfNeeded()
        }
}
