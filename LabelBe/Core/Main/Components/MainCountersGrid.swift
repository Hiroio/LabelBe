//
//  MainCountersGrid.swift
//  LabelBe
//

import SwiftUI

struct MainCountersGrid: View {
    let counters: [Counter]
    let isEditing: Bool
    let editIcon: String
    let showsRestore: Bool
    let onSelect: (Counter) -> Void
    let onEdit: (Counter) -> Void
    let onRestore: (Counter) -> Void

    private let columns = [
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppDesign.gridSpacing) {
                ForEach(counters, id: \.id) { counter in
                    cell(for: counter)
                }
            }
            .padding(.horizontal, AppDesign.gridPadding)
            .padding(.bottom, AppDesign.tabBarHeight + 12)
        }
        .scrollIndicators(.hidden)
    }
}

extension MainCountersGrid {
    @ViewBuilder
    private func cell(for counter: Counter) -> some View {
		HStack{
		  Button {
			 onSelect(counter)
		  } label: {
			 CounterCardView(counter: counter)
		  }
		  .buttonStyle(CounterCardButtonStyle())
		  if isEditing {
			 editCell(for: counter)
		}
		}
		.background(isEditing ? Color.red.opacity(0.85) : .clear, in: .rect(cornerRadius: AppDesign.cardCornerRadius))
    }

    private func editCell(for counter: Counter) -> some View {
        HStack(spacing: 0) {
            if showsRestore {
                Button {
                    onRestore(counter)
                } label: {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                }
                .buttonStyle(.plain)
            }

            Button {
                onEdit(counter)
            } label: {
                Image(systemName: editIcon)
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding(.horizontal, 5)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    MainCountersGrid(
        counters: [
            Counter(name: "Water", icon: "drop.fill"),
            Counter(name: "Run", icon: "figure.run"),
        ],
        isEditing: true,
        editIcon: "trash.fill",
        showsRestore: true,
        onSelect: { _ in },
        onEdit: { _ in },
        onRestore: { _ in }
    )
}
