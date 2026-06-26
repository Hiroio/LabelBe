//
//  CounterDetailHeaderView.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailHeaderView: View {
    let title: String
    let tags: [String]
    let isPinned: Bool
    let onClose: () -> Void
    let onEdit: () -> Void
    let onTogglePin: () -> Void

    var body: some View {
        VStack(spacing: AppDesign.spacingS) {
            HStack(spacing: 12) {
                Button("Close", systemImage: "xmark", action: onClose)
                    .headerCloseButton()

                Spacer()

                Text(title)
                    .font(.title2)
                    .bold()
                    .lineLimit(1)

                Spacer()

                HStack(spacing: 8) {
                    Button(action: onTogglePin) {
                        Image(systemName: isPinned ? "pin.fill" : "pin")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(isPinned ? AppDesign.accent : AppDesign.secondaryText)
                            .frame(width: AppDesign.headerButtonSize, height: AppDesign.headerButtonSize)
                            .background(AppDesign.elevated, in: .circle)
                    }
                    .accessibilityLabel(isPinned ? "Unpin counter" : "Pin counter")

                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(AppDesign.primaryText)
                            .frame(width: AppDesign.headerButtonSize, height: AppDesign.headerButtonSize)
                            .background(AppDesign.accent, in: .circle)
                    }
                    .accessibilityLabel("Edit counter")
                }
            }

            if !tags.isEmpty {
                CounterTagsDisplayView(tags: tags)
            }
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}

#Preview {
    CounterDetailHeaderView(
        title: "Water",
        tags: ["Health"],
        isPinned: true,
        onClose: {},
        onEdit: {},
        onTogglePin: {}
    )
    .background(AppBackgroundView())
}
