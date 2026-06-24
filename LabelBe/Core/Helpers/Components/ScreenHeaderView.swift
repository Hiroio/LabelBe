//
//  ScreenHeaderView.swift
//  LabelBe
//

import SwiftUI

struct ScreenHeaderView<Trailing: View>: View {
    let title: String
    @ViewBuilder var trailing: () -> Trailing

    init(title: String, @ViewBuilder trailing: @escaping () -> Trailing = { EmptyView() }) {
        self.title = title
        self.trailing = trailing
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            trailing()
        }
        .padding(.horizontal, AppDesign.screenPadding)
        .padding(.top, 8)
        .padding(.bottom, 4)
    }
}

#Preview {
    ScreenHeaderView(title: "Counters") {
        Button("Add", systemImage: "plus") {}
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .controlSize(.regular)
    }
    .background(AppBackgroundView())
}
