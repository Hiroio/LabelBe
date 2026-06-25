//
//  CounterMonthStatsSection.swift
//  LabelBe
//

import SwiftUI

struct CounterMonthStatsSection: View {
  @Binding var currentMonth: Date
  let breakdown: EntryBreakdown
  let chartData: [MonthPeriodTotal]
  let accent: Color
  
  var body: some View {
	 VStack(alignment: .leading, spacing: 12) {
		HStack{
		  Text("Month")
			 .font(.headline)
		 Spacer()
		  CustomMonthStepper(date: $currentMonth)
			 .foregroundStyle(accent)
		}
		CounterStatsSummaryCard(breakdown: breakdown, accent: accent)
		
		MonthPeriodChartView(data: chartData, accent: accent)
	 }
	 .animation(.easeInOut, value: currentMonth)
  }
}

#Preview {
  CounterMonthStatsSection(
	 currentMonth: .constant(.now),
	 breakdown: EntryBreakdown(pluses: 12, minuses: 3, total: 9),
	 chartData: [
		MonthPeriodTotal(id: 0, label: "1-7", total: 2, isCurrentPeriod: false),
		MonthPeriodTotal(id: 3, label: "22-28", total: 3, isCurrentPeriod: true),
	 ],
	 accent: AppDesign.accent
  )
  .padding()
}
