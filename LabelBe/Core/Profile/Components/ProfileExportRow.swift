//
//  ProfileExportRow.swift
//  LabelBe
//

import SwiftUI

struct ProfileExportRow: View {
    let exportURL: URL?

    var body: some View {
        Group {
            if let exportURL {
                ShareLink(item: exportURL) {
                    exportLabel
                }
            } else {
                exportLabel
                    .opacity(0.45)
            }
        }
    }

    private var exportLabel: some View {
        HStack(spacing: 14) {
            Image(systemName: "square.and.arrow.up")
                .font(.body)
                .foregroundStyle(AppDesign.accent)
                .frame(width: 28)

            Text("Export Data")
                .font(.body)
                .foregroundStyle(AppDesign.primaryText)

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption.weight(.semibold))
                .foregroundStyle(AppDesign.secondaryText)
        }
        .padding(.horizontal, AppDesign.spacingM)
        .padding(.vertical, 14)
    }
}

#Preview {
    ProfileExportRow(exportURL: URL(fileURLWithPath: "/tmp/test.csv"))
        .appCardSurface()
        .padding()
        .background(AppBackgroundView())
}
