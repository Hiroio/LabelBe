//
//  MainView.swift
//  LabelBe
//

import SwiftUI

struct MainView: View {
    @Environment(NavigationManager.self) private var navigation
    @State private var viewModel = MainViewModel()
    @State private var createViewModel = CreateCounterViewModel()
    @State private var isShowingCreateSheet = false

    var body: some View {
        VStack(spacing: 0) {
            header

            if viewModel.counters.isEmpty {
                MainEmptyStateView(onAdd: openCreation)
            } else {
                ScrollView {
                    VStack(spacing: AppDesign.sectionSpacing) {
                        MainLatestCountersSection(counters: viewModel.latestCounters)

                        MainWeekComparisonSection(comparison: viewModel.weekComparison) {
                            navigation.counterScreen = .weekComparison(tag: nil)
                        }

                        statsCard
                    }
                    .padding(.horizontal, AppDesign.screenPadding)
                    .padding(.bottom, AppDesign.tabBarHeight + AppDesign.spacingL)
                }
                .scrollIndicators(.hidden)
            }
        }
        .animation(.easeInOut, value: viewModel.counters.count)
        .onAppear {
            viewModel.refreshCounters()
        }
        .sheet(isPresented: $isShowingCreateSheet) {
            CreateCounterSheet(viewModel: createViewModel, onCreate: submitNewCounter)
        }
        .onChange(of: isShowingCreateSheet) { _, isShowing in
            if !isShowing {
                createViewModel.reset()
            }
        }
    }

    private var statsCard: some View {
        VStack(spacing: AppDesign.spacingM) {
            HStack {
                Text("Stats")
                    .font(.headline)
                    .foregroundStyle(AppDesign.primaryText)

                Spacer()

                Button {
                    navigation.counterScreen = .stats
                } label: {
                    Text("See all")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppDesign.accent)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, AppDesign.spacingM)
            .padding(.top, AppDesign.spacingM)

            MainTodaySummarySection(breakdown: viewModel.todayBreakdown)
                .padding(.horizontal, AppDesign.spacingM)

            MainMonthChartSection(monthPeriods: viewModel.currentMonthPeriods) {
                navigation.counterScreen = .stats
            }

            MainTodayStatsSection(rows: viewModel.topTodayRows)
        }
        .appCardSurface()
    }

    private func openCreation() {
        isShowingCreateSheet = true
    }

    private func submitNewCounter() {
        viewModel.createCounter(
            name: createViewModel.trimmedName,
            icon: createViewModel.selectedIcon,
            tags: createViewModel.tags
        )
    }
}

extension MainView {
    private var header: some View {
        HStack {
            Text("LabelBe")
                .font(.title2.weight(.semibold))
                .foregroundStyle(AppDesign.primaryText)

            Spacer()

            Button(action: openCreation) {
                Image(systemName: "plus")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(AppDesign.primaryText)
                    .frame(width: 40, height: 40)
                    .background(AppDesign.accent, in: .circle)
            }
            .accessibilityLabel("Add counter")
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, AppDesign.spacingM)
        .padding(.bottom, AppDesign.spacingS)
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        MainView()
    }
    .environment(NavigationManager.shared)
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
