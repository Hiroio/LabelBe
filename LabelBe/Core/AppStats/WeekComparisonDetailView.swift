//
//  WeekComparisonDetailView.swift
//  LabelBe
//

import SwiftUI

struct WeekComparisonDetailView: View {
    @Environment(NavigationManager.self) private var navigation
    let selectedTag: String?

    private let dataManager = SwiftDataManager.shared

    private var counters: [Counter] {
        dataManager.fetchActiveCounters().filtered(byTag: selectedTag)
    }

    private var comparison: WeekComparison {
        counters.weekComparison()
    }

    private var dayPoints: [WeekChartPoint] {
        counters.weekChartPoints()
    }

    var body: some View {
        VStack(spacing: 0) {
            SecondaryScreenHeaderView(title: "Week Comparison", onClose: dismiss)

            ScrollView {
                VStack(spacing: AppDesign.sectionSpacing) {
                    MainWeekComparisonSection(comparison: comparison)

                    totalsCard

                    dailyCard
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

    private var totalsCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            Text("Weekly Totals")
                .font(.headline)
                .foregroundStyle(AppDesign.primaryText)

            WeekComparisonTotalsChart(comparison: comparison, accent: AppDesign.accent)
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }

    private var dailyCard: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingM) {
            Text("By Day")
                .font(.headline)
                .foregroundStyle(AppDesign.primaryText)

            WeekComparisonDaysChart(points: dayPoints, accent: AppDesign.accent)
        }
        .padding(AppDesign.spacingM)
        .appCardSurface()
    }

    private func dismiss() {
        navigation.counterScreen = nil
    }
}

#Preview {
    WeekComparisonDetailView(selectedTag: nil)
        .environment(NavigationManager.shared)
        .onAppear {
            PreviewSupport.configureIfNeeded()
        }
}
