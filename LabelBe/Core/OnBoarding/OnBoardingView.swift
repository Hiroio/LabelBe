//
//  OnBoardingView.swift
//  LabelBe
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("OnBoarding") private var onBoardingState = false
    @State private var selection = 0

    var body: some View {
        ZStack {
            AppBackgroundView()

            VStack(spacing: 0) {
                TabView(selection: $selection) {
                    FirstOnBoardingView()
                        .tag(0)

                    SecondOnBoardingView()
                        .tag(1)

                    ThirdOnBoardingView()
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))

                Button {
                    withAnimation(AppDesign.tabAnimation) {
                        if selection == 2 {
                            onBoardingState = false
                        } else {
                            selection += 1
                        }
                    }
                } label: {
                    Text(selection == 2 ? "Begin" : "Continue")
                        .font(.headline)
                        .foregroundStyle(AppDesign.primaryText)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(AppDesign.accent)
                        )
                }
                .padding(.horizontal, AppDesign.screenPadding)
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
