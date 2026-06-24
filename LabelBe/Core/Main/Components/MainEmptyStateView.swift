//
//  MainEmptyStateView.swift
//  LabelBe
//

import SwiftUI

struct MainEmptyStateView: View {
    let onAdd: () -> Void

    var body: some View {
        VStack(spacing: AppDesign.sectionSpacing) {
            Spacer()

            ContentUnavailableView {
                Label("Create your first Counter", systemImage: "plus.slash.minus")
            } description: {
                Text("Track habits, goals, and daily counts in one clean place.")
            } actions: {
                addButton(action: onAdd)
            }

            Spacer()
        }
        .padding(.horizontal, AppDesign.screenPadding)
    }
}

extension MainEmptyStateView {
    func addButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "plus")
        }
        .buttonStyle(EmptyStateAddButtonStyle())
        .accessibilityLabel("Add Counter")
    }
}

#Preview {
    MainEmptyStateView(onAdd: {})
}
