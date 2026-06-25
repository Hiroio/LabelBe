//
//  CounterCardView.swift
//  LabelBe
//

import SwiftUI

struct CounterCardView: View {
    let counter: Counter

    private var accent: Color {
        AppDesign.cardAccent(for: counter.id)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Image(systemName: counter.icon)
                .font(.title3)
                .foregroundStyle(accent)
                .accentIconBadge(color: accent, size: 40)

            VStack(alignment: .leading, spacing: 2) {
                Text(counter.name)
                    .font(.subheadline)
                    .foregroundStyle(AppDesign.primaryText)
                    .lineLimit(2)

                Text(counter.total, format: .number)
                    .font(.system(.title2, design: .rounded))
                    .bold()
                    .monospacedDigit()
                    .foregroundStyle(accent)
                    .contentTransition(.numericText())
            }
        }
        .frame(maxWidth: .infinity, minHeight: AppDesign.cardMinHeight, alignment: .topLeading)
        .padding(16)
        .counterCardSurface()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(counter.name), \(counter.total)")
    }
}

#Preview {
    VStack(spacing: 14) {
        CounterCardView(counter: Counter(name: "Water", icon: "drop.fill"))
        CounterCardView(counter: Counter(name: "Workouts", icon: "figure.run"))
    }
    .padding()
    .background(AppBackgroundView())
}
