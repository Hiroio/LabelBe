//
//  TagScroll.swift
//  LabelBe
//

import SwiftUI

struct TagScroll: View {
    let tags: [String]
    var selectedTag: Binding<String?>? = nil
    var isEditable: Bool = false
    var onRemove: ((String) -> Void)? = nil
    var onSelect: ((String) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: AppDesign.spacingS) {
                if let selectedTag {
                    filterChip(title: "All", isSelected: selectedTag.wrappedValue == nil) {
                        selectedTag.wrappedValue = nil
                    }

                    ForEach(tags, id: \.self) { tag in
                        filterChip(title: tag, isSelected: selectedTag.wrappedValue == tag) {
                            selectedTag.wrappedValue = selectedTag.wrappedValue == tag ? nil : tag
                            onSelect?(tag)
                        }
                    }
                } else {
                    ForEach(tags, id: \.self) { tag in
                        tagChip(tag)
                    }
                }
            }
            .padding(.vertical, 2)
        }
        .scrollIndicators(.hidden)
    }
}

extension TagScroll {
    private func tagChip(_ tag: String) -> some View {
        HStack(spacing: 5) {
            Text(tag)

            if isEditable {
                Image(systemName: "xmark")
            }
        }
        .font(.caption)
        .foregroundStyle(AppDesign.accent)
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: AppDesign.cardCornerRadius, style: .continuous)
                .stroke(AppDesign.accent, lineWidth: 1)
        }
        .contentShape(.rect)
        .onTapGesture {
            guard isEditable else { return }
            onRemove?(tag)
        }
    }

    private func filterChip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(isSelected ? AppDesign.primaryText : AppDesign.secondaryText)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background {
                    RoundedRectangle(cornerRadius: AppDesign.cardCornerRadius, style: .continuous)
                        .fill(isSelected ? AppDesign.accent.opacity(0.35) : AppDesign.elevated)
                }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 16) {
        TagScroll(
            tags: ["Health", "Work"],
            isEditable: true,
            onRemove: { _ in }
        )

        TagScroll(
            tags: ["Health", "Work"],
            selectedTag: .constant("Health")
        )
    }
    .padding()
    .background(AppBackgroundView())
}
