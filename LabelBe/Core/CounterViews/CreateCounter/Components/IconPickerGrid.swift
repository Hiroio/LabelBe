//
//  IconPickerGrid.swift
//  LabelBe
//

import SwiftUI

struct IconPickerGrid: View {
    @Binding var selection: String

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(CounterIconCatalog.icons, id: \.self) { icon in
                    IconPickerCell(icon: icon, isSelected: selection == icon) {
                        selection = icon
                    }
                }
            }
        }
        .frame(maxHeight: 132)
        .scrollIndicators(.hidden)
    }
}

private struct IconPickerCell: View {
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
        }
        .buttonStyle(IconPickerButtonStyle(isSelected: isSelected))
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(icon)
    }
}

#Preview {
    @Previewable @State var selection = CounterIconCatalog.defaultIcon

    IconPickerGrid(selection: $selection)
        .padding()
}
