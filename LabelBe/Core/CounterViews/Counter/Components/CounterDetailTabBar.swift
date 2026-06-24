//
//  CounterDetailTabBar.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailTabBar: View {
    @Binding var selectedTab: CounterDetailTab

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                ForEach(CounterDetailTab.allCases) { tab in
                    tabButton(for: tab)
                }
            }

            HStack(spacing: 0) {
                ForEach(CounterDetailTab.allCases) { tab in
                    tabIndicator(for: tab)
                }
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}

#Preview {
    @Previewable @State var tab: CounterDetailTab = .counter

    CounterDetailTabBar(selectedTab: $tab)
}


extension CounterDetailTabBar{
  private func tabButton(for tab: CounterDetailTab) -> some View {
		Button(tab.title) {
			 selectedTab = tab
		}
		.font(selectedTab == tab ? .title3 : .body)
		.foregroundStyle(selectedTab == tab ? AppDesign.accent : .secondary)
		.frame(maxWidth: .infinity)
  }

  private func tabIndicator(for tab: CounterDetailTab) -> some View {
		Group {
			 if selectedTab == tab {
				  RoundedRectangle(cornerRadius: 2, style: .continuous)
						.fill(AppDesign.accent)
						.frame(width: 36, height: 3)
			 } else {
				  Color.clear
						.frame(width: 36, height: 3)
			 }
		}
		.frame(maxWidth: .infinity)
  }
}
