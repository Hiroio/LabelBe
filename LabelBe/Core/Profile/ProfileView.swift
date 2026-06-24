//
//  ProfileView.swift
//  LabelBe
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()

    private let privacyPolicyURL = URL(string: "https://example.com/privacy")!
    private let termsOfUseURL = URL(string: "https://example.com/terms")!

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeaderView(title: "Profile")

            ScrollView {
                VStack(spacing: AppDesign.sectionSpacing) {
                    ProfileCardView()

                    ProfileTotalStatsSection(
                        breakdown: viewModel.currentMonthBreakdown,
                        monthPeriods: viewModel.currentMonthPeriods
                    )

                    ProfileSettingsTogglesCard(viewModel: viewModel)

                    ProfileSettingsCardView(
                        privacyPolicyURL: privacyPolicyURL,
                        termsOfUseURL: termsOfUseURL
                    )

                    Text("Version 1.0.0 (1)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                }
                .padding(.horizontal, AppDesign.screenPadding)
                .padding(.bottom, 16)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.refresh()
        }
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        ProfileView()
    }
    .onAppear {
        PreviewSupport.configureIfNeeded()
    }
}
