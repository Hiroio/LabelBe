//
//  CounterTemplatesScroll.swift
//  LabelBe
//

import SwiftUI

struct CounterTemplatesScroll: View {
    let onSelect: (CounterTemplate) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingS) {
            Text("Templates")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppDesign.secondaryText)

            ScrollView(.horizontal) {
                HStack(spacing: AppDesign.spacingS) {
                    ForEach(CounterTemplateCatalog.templates) { template in
                        Button {
                            onSelect(template)
                        } label: {
                            VStack(spacing: 8) {
                                Image(systemName: template.icon)
                                    .font(.body)
                                    .foregroundStyle(AppDesign.accent)
                                    .frame(width: 40, height: 40)
                                    .background(AppDesign.accentMuted, in: .circle)

                                Text(template.name)
                                    .font(.caption)
                                    .foregroundStyle(AppDesign.primaryText)
                                    .lineLimit(1)
                            }
                            .frame(width: 72)
                            .padding(.vertical, 10)
                            .background(AppDesign.elevated, in: .rect(cornerRadius: AppDesign.inputCornerRadius))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    CounterTemplatesScroll(onSelect: { _ in })
        .padding()
        .background(AppBackgroundView())
}
