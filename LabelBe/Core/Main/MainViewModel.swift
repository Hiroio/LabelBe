//
//  MainViewModel.swift
//  LabelBe
//

import Foundation

@Observable
final class MainViewModel {
  private let dataManager = SwiftDataManager.shared
  private let soundManager = SoundManager.shared
  
  private(set) var counters: [Counter] = []
  
  init() {
	 refreshCounters()
  }
  
  func refreshCounters() {
	 counters = dataManager.fetchCounters()
  }
  
  func createCounter(name: String, icon: String) {
	 let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
	 guard !trimmed.isEmpty else { return }
	 
	 dataManager.addCounter(name: trimmed, icon: icon)
	 refreshCounters()
  }
  
  func recordTap(on counter: Counter, value: Int) {
	 guard value == 1 || value == -1 else { return }
	 
	 dataManager.addEntry(to: counter, value: value)
	 
	 if value == 1 {
		soundManager.playPlusSound()
	 } else {
		soundManager.playMinusSound()
	 }
	 
	 refreshCounters()
  }
}
