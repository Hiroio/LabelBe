//
//  MainView.swift
//  LabelBe
//

import SwiftUI

struct MainView: View {
  @Environment(NavigationManager.self) private var navigation
  @State private var viewModel = MainViewModel()
  @State private var createViewModel = CreateCounterViewModel()
  @State private var isShowingCreateSheet = false
  @State private var isEditing: Bool = false
  var body: some View {
	 VStack(spacing: 0) {
		ScreenHeaderView(title: "Labels") {
		  HStack{
			 headerAddButton(action: openCreation)
			 if !viewModel.counters.isEmpty {
				headerEditButton(action: {
				  withAnimation {
					 isEditing.toggle()
				  }
				})
			 }
		  }
		}
		
		if viewModel.counters.isEmpty {
		  MainEmptyStateView(onAdd: openCreation)
		} else {
		  MainCountersGrid(counters: viewModel.counters, onSelect: openCounter,onDelete: deleteCounter, editingState: isEditing)
		}
	 }
	 .animation(.easeInOut, value: viewModel.counters.count)
	 .onAppear {
		viewModel.refreshCounters()
	 }
	 .alert("Are you Sure?", isPresented: Binding(get: {
		viewModel.selectedCounter != nil
	 }, set: { _ in
		viewModel.selectedCounter = nil
	 }), actions: {
		Button(role: .destructive) {
		  viewModel.deleteCounter()
		} label: {
		  Text("Delete")
		}
	 }, message: {
		Text("This action can't be retreat")
	 })
	 .sheet(isPresented: $isShowingCreateSheet) {
		CreateCounterSheet(viewModel: createViewModel, onCreate: submitNewCounter)
	 }
	 .onChange(of: isShowingCreateSheet) { _, isShowing in
		if !isShowing {
		  createViewModel.reset()
		}
	 }
  }
  
  private func openCreation() {
	 isShowingCreateSheet = true
  }
  
  private func submitNewCounter() {
	 viewModel.createCounter(
		name: createViewModel.trimmedName,
		icon: createViewModel.selectedIcon
	 )
  }
  
  private func openCounter(_ counter: Counter) {
	 navigation.counterScreen = .counter(counter)
  }
  
  private func deleteCounter(_ counter: Counter){
	 withAnimation{
		viewModel.selectedCounter = counter
	 }
  }
}

extension MainView {
  func headerAddButton(action: @escaping () -> Void) -> some View {
	 Button(action: action) {
		Image(systemName: "plus")
	 }
	 .buttonStyle(AccentCircleButtonStyle())
	 .accessibilityLabel("Add")
  }
  func headerEditButton(action: @escaping () -> Void) -> some View {
	 Button(action: action) {
		Image(systemName: "pencil")
	 }
	 .buttonStyle(AccentCircleButtonStyle())
	 .accessibilityLabel("Edit")
  }
}

#Preview {
  ZStack {
	 AppBackgroundView()
	 MainView()
  }
  .environment(NavigationManager.shared)
  .onAppear {
	 PreviewSupport.configureIfNeeded()
  }
}
