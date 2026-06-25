//
//  CounterTagView.swift
//  LabelBe
//

import SwiftUI

struct CounterTagView: View {
    @Binding var tags: [String]
    @State private var tagText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: AppDesign.spacingS) {
            Text("Tags")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(AppDesign.secondaryText)

            HStack(spacing: AppDesign.spacingS) {
                TextField(
                    "",
                    text: $tagText,
                    prompt: Text("Add tag").foregroundStyle(AppDesign.secondaryText)
                )
                .font(.subheadline)
                .foregroundStyle(AppDesign.primaryText)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .inputFieldSurface()

                Button {
                    withAnimation(AppDesign.quickAnimation) {
                        addTag()
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(AppDesign.primaryText)
                        .frame(width: 36, height: 36)
                        .background(AppDesign.accent, in: .circle)
                }
                .accessibilityLabel("Add tag")
            }

            if !tags.isEmpty {
                TagScroll(
                    tags: tags,
                    isEditable: true,
                    onRemove: removeTag
                )
            }
        }
    }

    private func addTag() {
        let trimmed = tagText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        guard !tags.contains(where: { $0.lowercased() == trimmed.lowercased() }) else {
            tagText = ""
            return
        }
        tags.insert(trimmed, at: 0)
        tagText = ""
    }

    private func removeTag(_ tag: String) {
        tags.removeAll { $0 == tag }
    }
}

#Preview {
    CounterTagView(tags: .constant(["Health", "Work"]))
        .padding()
        .background(AppBackgroundView())
}
