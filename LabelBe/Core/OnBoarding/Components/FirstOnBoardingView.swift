//
//  FirstOnBoardingView.swift
//  LabelBe
//

import SwiftUI

struct FirstOnBoardingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.top, 48)

            Spacer()

            VStack(spacing: 14) {
                Text("Simple counters for the habits that matter.")
                    .font(.title2.weight(.bold))
                    .fontDesign(.rounded)
                    .multilineTextAlignment(.center)

                Text("LabelBe helps you track daily goals, stay consistent, and see your progress over time.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, AppDesign.screenPadding)

            Spacer()
        }
    }
}

#Preview {
    ZStack {
        AppBackgroundView()
        FirstOnBoardingView()
    }
	 .preferredColorScheme(.dark)
}
