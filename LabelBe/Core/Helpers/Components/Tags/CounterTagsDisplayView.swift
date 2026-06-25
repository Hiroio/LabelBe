//
//  CounterTagsDisplayView.swift
//  LabelBe
//

import SwiftUI

struct CounterTagsDisplayView: View {
    let tags: [String]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.spacingS) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .foregroundStyle(AppDesign.accent)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CounterTagsDisplayView(tags: ["Health", "Personal"])
        .padding()
        .background(AppBackgroundView())
}
