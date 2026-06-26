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

    private var streak: Int {
        counter.currentStreak()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: counter.icon)
                    .font(.title3)
                    .foregroundStyle(accent)
                    .accentIconBadge(color: accent, size: 40)

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    if counter.isPinned {
                        Image(systemName: "pin.fill")
                            .font(.caption2)
                            .foregroundStyle(AppDesign.accent)
                    }

                    if streak > 0 {
                        HStack(spacing: 3) {
                            Image(systemName: "flame.fill")
                                .font(.caption2)
                            Text("\(streak)")
                                .font(.caption.weight(.semibold))
                                .monospacedDigit()
                        }
                        .foregroundStyle(accent)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(accent.opacity(0.18), in: .capsule)
                    }
                }
            }

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
