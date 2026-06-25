//
//  CustomMonthStepper.swift
//  LabelBe
//
//  Created by user on 25.06.2026.
//

import SwiftUI

struct CustomMonthStepper: View {
  @Binding var date: Date
    var body: some View {
		HStack{
		  Button{
			 date = Calendar.current.date(byAdding: .month, value: -1, to: date)!
		  }label:{
			 Image(systemName: "chevron.left")
		  }
		  .accessibilityLabel("Previous Month")
		  
		  Text(date.formatted(.dateTime.month(.wide)))
		  
		  Button{
			 date = Calendar.current.date(byAdding: .month, value: 1, to: date)!
		  }label:{
			 Image(systemName: "chevron.right")
		  }
		  .accessibilityLabel("Next Month")
		}
		.animation(.bouncy, value: date)
    }
}

#Preview {
  CustomMonthStepper(date: .constant(.now))
}
