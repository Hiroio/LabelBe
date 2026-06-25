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
        ScrollView {
            VStack(spacing: 20) {
                SelectedIconPreview(icon: viewModel.selectedIcon)
                    .padding(.top, 8)

                CreateCounterNameField(name: $viewModel.name)

                CounterTagView(tags: $viewModel.tags)
                    .padding(.bottom, 4)

                IconPickerGrid(selection: $viewModel.selectedIcon)

                Button("Create Counter", action: create)
                    .buttonStyle(AccentProminentButtonStyle())
                    .disabled(!viewModel.canCreate)
            }
            .padding(.horizontal, AppDesign.screenPadding)
            .padding(.vertical, 20)
        }
        .scrollIndicators(.hidden)
        .overlay(alignment: .topTrailing) {
            Button("Cancel") {
                dismiss()
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .padding(.top, 12)
            .padding(.trailing, AppDesign.screenPadding)
        }
        .presentationDetents([.large])
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
