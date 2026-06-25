//
//  ProfileTotalStatsSection.swift
//  LabelBe
//

import SwiftUI

struct ProfileTotalStatsSection: View {
    let breakdown: EntryBreakdown

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Total")
                .font(.headline)

            CounterStatsSummaryCard(
                breakdown: breakdown,
                accent: AppDesign.accent
            )
        }
    }
}

#Preview {
    ProfileTotalStatsSection(
        breakdown: EntryBreakdown(pluses: 8, minuses: 2, total: 6)
    )
    .padding()
}
