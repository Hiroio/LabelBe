//
//  GridSearchField.swift
//  LabelBe
//

import SwiftUI

struct GridSearchField: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: AppDesign.spacingS) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppDesign.secondaryText)

            TextField(
                "",
                text: $text,
                prompt: Text("Search counters").foregroundStyle(AppDesign.secondaryText)
            )
            .font(.subheadline)
            .foregroundStyle(AppDesign.primaryText)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppDesign.secondaryText)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(AppDesign.elevated, in: .rect(cornerRadius: AppDesign.inputCornerRadius))
    }
}

#Preview {
    @Previewable @State var text = ""

    GridSearchField(text: $text)
        .padding()
        .background(AppBackgroundView())
}
