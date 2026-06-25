//
//  MainCountersGrid.swift
//  LabelBe
//

import SwiftUI

struct MainCountersGrid: View {
    let counters: [Counter]
    let onSelect: (Counter) -> Void
  let onDelete: (Counter) -> Void
  let editingState: Bool
    private let columns = [
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
        GridItem(.flexible(), spacing: AppDesign.gridSpacing),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: AppDesign.gridSpacing) {
                ForEach(counters, id: \.id) { counter in
                    Button {
							 if editingState{
								onDelete(counter)
							 }else{
								onSelect(counter)
							 }
                    } label: {
							 HStack{
								CounterCardView(counter: counter)
								  .shadow(radius: 2)
								if editingState{
								  Image(systemName: "trash.fill")
									 .foregroundStyle(.white)
									 .font(.title)
									 .padding(.horizontal)
								}
							 }
							 .background(editingState ? .red : .clear, in: .rect(cornerRadius: AppDesign.cardCornerRadius))
                    }
                    .buttonStyle(CounterCardButtonStyle())
                }
            }
            .padding(.horizontal, AppDesign.gridPadding)
            .padding(.bottom, AppDesign.tabBarHeight + 12)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    MainCountersGrid(
        counters: [
            Counter(name: "Water", icon: "drop.fill"),
            Counter(name: "Run", icon: "figure.run"),
        ],
        onSelect: { _ in },
		  onDelete: {_ in},
		  editingState: true
    )
}
