//
//  GridEmptyStateView.swift
//  LabelBe
//

import SwiftUI

struct GridEmptyStateView: View {
    let onCreate: () -> Void

    var body: some View {
        VStack(spacing: AppDesign.spacingM) {
            Spacer()

            Image(systemName: "rectangle.grid.2x2")
                .font(.system(size: 44))
                .foregroundStyle(AppDesign.accent)

            Text("No counters yet")
                .font(.title3.weight(.semibold))
                .foregroundStyle(AppDesign.primaryText)

            Text("Add your first counter to start tracking habits and daily counts.")
                .font(.body)
                .foregroundStyle(AppDesign.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppDesign.spacingL)

            Button(action: onCreate) {
                Text("Add Counter")
            }
            .buttonStyle(AccentProminentButtonStyle())
            .padding(.horizontal, AppDesign.spacingL)
            .padding(.top, AppDesign.spacingS)

            Spacer()
        }
    }
}

#Preview {
    GridEmptyStateView(onCreate: {})
        .background(AppBackgroundView())
}
