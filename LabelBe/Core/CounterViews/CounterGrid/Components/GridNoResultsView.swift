//
//  GridNoResultsView.swift
//  LabelBe
//

import SwiftUI

struct GridNoResultsView: View {
    var title: String = "Nothing found"
    var message: String = "Try a different search term or clear your filters."

    var body: some View {
        VStack(spacing: AppDesign.spacingM) {
            Spacer()

            Image(systemName: "magnifyingglass")
                .font(.system(size: 44))
                .foregroundStyle(AppDesign.accent)

            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundStyle(AppDesign.primaryText)

            Text(message)
                .font(.body)
                .foregroundStyle(AppDesign.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppDesign.spacingL)

            Spacer()
        }
    }
}

#Preview {
    GridNoResultsView()
        .background(AppBackgroundView())
}
