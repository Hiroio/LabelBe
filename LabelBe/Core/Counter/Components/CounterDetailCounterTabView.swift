//
//  CounterDetailCounterTabView.swift
//  LabelBe
//

import SwiftUI

struct CounterDetailCounterTabView: View {
    let viewModel: CounterDetailViewModel
    let onMinus: () -> Void
    let onPlus: () -> Void

    var body: some View {
        VStack(spacing: 0) {
			 CounterIconView(
                icon: viewModel.counter.icon,
                accent: viewModel.accent
            )
			 
            Spacer()

            VStack(spacing: 8) {
				  TodaysDayView
						.padding(.top, 12)
				  
                Text(viewModel.todayTotal, format: .number)
                    .font(.system(size: 72, weight: .bold, design: .rounded))
                    .monospacedDigit()
                    .foregroundStyle(viewModel.accent)
                    .contentTransition(.numericText())

                Text("Total: \(viewModel.total)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .id(viewModel.refreshID)

            Spacer()

            CounterStepButtonsView(
                accent: viewModel.accent,
                onMinus: onMinus,
                onPlus: onPlus
            )
        }
    }
}

#Preview {
    CounterDetailCounterTabView(
        viewModel: CounterDetailViewModel(counter: Counter(name: "Water", icon: "drop.fill")),
        onMinus: {},
        onPlus: {}
    )
}


extension CounterDetailCounterTabView{
  private var TodaysDayView: some View{
	 VStack(spacing: 2) {
		let date = Date.now
		  Text(date, format: .dateTime.day())
				.font(.headline)
				.fontDesign(.rounded)
				.monospacedDigit()

		  Text(date, format: .dateTime.month(.wide))
				.font(.caption)
				.foregroundStyle(.secondary)
	 }
  }
  
  private func CounterIconView(icon: String, accent: Color) -> some View {
	 Image(systemName: icon)
		  .font(.system(size: 36))
		  .foregroundStyle(AppDesign.accent)
		  .accentIconBadge(color: AppDesign.accent, size: 72)
		  .padding(.top, 8)
		  .accessibilityHidden(true)
  }
}
