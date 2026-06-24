//
//  SelectedIconPreview.swift
//  LabelBe
//

import SwiftUI

struct SelectedIconPreview: View {
    let icon: String

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 40))
            .foregroundStyle(AppDesign.accent)
            .accentIconBadge(color: AppDesign.accent, size: 88)
            .accessibilityLabel("Selected icon")
    }
}

#Preview {
    SelectedIconPreview(icon: "drop.fill")
}
