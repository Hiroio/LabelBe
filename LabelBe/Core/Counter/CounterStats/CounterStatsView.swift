//
//  CounterStatsView.swift
//  LabelBe
//

import SwiftUI

struct CounterStatsView: View {
    @State private var viewModel: CounterStatsViewModel

    init(counter: Counter) {
        _viewModel = State(initialValue: CounterStatsViewModel(counter: counter))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: AppDesign.sectionSpacing) {
                CounterTodayStatsSection(
                    breakdown: viewModel.todayBreakdown,
                    chartData: viewModel.last7Days,
                    accent: viewModel.accent
                )

                CounterMonthStatsSection(
                    breakdown: viewModel.monthBreakdown,
                    chartData: viewModel.currentMonthPeriods,
                    accent: viewModel.accent
                )
            }
            .padding(.horizontal, AppDesign.screenPadding)
            .padding(.vertical, 16)
            .padding(.bottom, 8)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CounterStatsView(counter: Counter(name: "Water", icon: "drop.fill"))
        .onAppear {
            PreviewSupport.configureIfNeeded()
        }
}
