//
//  SecondOnBoardingView.swift
//  LabelBe
//

import SwiftUI

struct SecondOnBoardingView: View {
    @State private var demoCount = 3

    var body: some View {
        VStack(spacing: 0) {
            pageHeader(
                title: "Create & Count",
                description: "Add a habit, pick an icon, and update it with quick plus and minus taps."
            )

            Spacer()

            habitDemo

            Spacer()
        }
    }
}

extension SecondOnBoardingView {
    private func pageHeader(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)

            Text(description)
                .font(.body)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, 32)
    }

    private var habitDemo: some View {
        VStack(spacing: 24) {
            Image(systemName: "star.fill")
                .font(.system(size: 36))
                .foregroundStyle(AppDesign.accent)
                .accentIconBadge(color: AppDesign.accent, size: 72)

            VStack(spacing: 6) {
                Text("Your Habit")
                    .font(.headline)

                Text(demoCount, format: .number)
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(AppDesign.accent)
                    .contentTransition(.numericText())
            }

            CounterStepButtonsView(
                accent: AppDesign.accent,
                onMinus: { demoCount = max(0, demoCount - 1) },
                onPlus: { demoCount += 1 }
            )
            .padding(.bottom, 0)
        }
        .padding(.vertical, 28)
        .padding(.horizontal, 32)
        .appCardSurface()
        .padding(.horizontal, AppDesign.screenPadding)
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        SecondOnBoardingView()
    }
}
