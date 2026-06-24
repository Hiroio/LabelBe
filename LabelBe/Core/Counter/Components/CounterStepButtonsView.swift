//
//  CounterStepButtonsView.swift
//  LabelBe
//

import SwiftUI

struct CounterStepButtonsView: View {
    let accent: Color
    let onMinus: () -> Void
    let onPlus: () -> Void

    var body: some View {
        HStack(spacing: 48) {
            Button("Minus", systemImage: "minus", action: onMinus)
                .buttonStyle(CounterStepButtonStyle(accent: accent))

            Button("Plus", systemImage: "plus", action: onPlus)
                .buttonStyle(CounterStepButtonStyle(accent: accent))
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    CounterStepButtonsView(accent: .indigo, onMinus: {}, onPlus: {})
}
