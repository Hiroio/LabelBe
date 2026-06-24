//
//  RootView.swift
//  LabelBe
//

import SwiftUI

struct RootView: View {
  @Environment(NavigationManager.self) private var navigation
  @AppStorage("OnBoarding") private var onBoardingState = false
  @State private var firstLaunch: Bool = true
  @State private var secondLaunch: Bool = true
  var body: some View {
	 ZStack {
		AppBackgroundView()
		if firstLaunch{
		  LoadingView()
			 .onAppear{
				DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
				  firstLaunch.toggle()
				}
			 }
		}else{
		  if onBoardingState{
			 
			 MainNavigationView()
			 
			 if let counterScreen = navigation.counterScreen {
				CounterDetailView(counter: counter(from: counterScreen))
				  .transition(.move(edge: .bottom).combined(with: .opacity))
				  .zIndex(1)
				
			 }
		  }else{
			 OnBoardingView()
		  }
		}
	 }
	 .animation(AppDesign.tabAnimation, value: navigation.counterScreen != nil)
	 .animation(.easeInOut, value: onBoardingState)
	 .animation(.easeInOut, value: firstLaunch)
  }
	 
	 private func counter(from screen: SecondaryScreensEnum) -> Counter {
		switch screen {
		case .counter(let counter):
		  counter
		}
	 }
  }
  
  #Preview {
	 RootView()
		.environment(NavigationManager.shared)
		.onAppear {
		  PreviewSupport.configureIfNeeded()
		}
  }
