//
//  CreateCounterSheet.swift
//  LabelBe
//

import SwiftUI

struct CreateCounterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: CreateCounterViewModel

    let onCreate: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            SelectedIconPreview(icon: viewModel.selectedIcon)
                .padding(.top, 8)

            CreateCounterNameField(name: $viewModel.name)

            IconPickerGrid(selection: $viewModel.selectedIcon)

            Spacer(minLength: 0)

            Button("Create Counter", action: create)
                .buttonStyle(AccentProminentButtonStyle())
                .disabled(!viewModel.canCreate)
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.vertical, 20)
        .overlay(alignment: .topTrailing) {
            Button("Cancel") {
                dismiss()
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.top, 12)
            .padding(.trailing, AppDesign.screenPadding)
        }
        .presentationDetents([.height(420)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(AppDesign.cardCornerRadius)
    }

    private func create() {
        onCreate()
        dismiss()
    }
}

#Preview {
    @Previewable @State var viewModel = CreateCounterViewModel()

    CreateCounterSheet(viewModel: viewModel, onCreate: {})
}
