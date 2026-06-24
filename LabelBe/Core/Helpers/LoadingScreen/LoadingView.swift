//
//  LoadingView.swift
//  LabelBe
//
//  Created by user on 24.06.2026.
//

import SwiftUI

struct LoadingView: View {
  @State private var startLoading: Bool = false
  let duration: Double
  init(duration: Double = 1.5){
	 self.duration = duration
  }
    var body: some View {
		VStack{
		  Spacer()
		  Image("Logo")
			 .resizable()
			 .scaledToFit()
			 .frame(height: 150)
		  Spacer()
		  
		  ZStack(alignment: .leading){
			 RoundedRectangle(cornerRadius: 20)
				.fill(.ultraThinMaterial)
				.frame(maxWidth: .infinity)
				.frame(height: 15)
			 
			 RoundedRectangle(cornerRadius: 20)
				.frame(maxWidth: startLoading ? .infinity : 0)
				.frame(height: 10)
		  }
		  .foregroundStyle(AppDesign.accent)
		  .padding()
		  
		}
		.onAppear{
		  withAnimation(.easeInOut(duration: duration)){
			 startLoading.toggle()
		  }
		}
    }
}

#Preview {
    LoadingView()
}
