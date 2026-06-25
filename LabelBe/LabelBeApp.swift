//
//  LabelBeApp.swift
//  LabelBe
//

import SwiftData
import SwiftUI
import WidgetKit

@main
struct LabelBeApp: App {
  @AppStorage("profile.notificationsEnabled") var notification: Bool = false
  private let modelContainer: ModelContainer
  @State private var navigation: NavigationManager = .shared
  init() {
	 let _ = NotificationManager.shared
	 do {
		modelContainer = try ModelContainer(for: Counter.self, CounterEntry.self)
	 } catch {
		fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
	 }
	 
	 SwiftDataManager.shared.configure(modelContext: modelContainer.mainContext)
  }
  
  var body: some Scene {
	 WindowGroup {
		RootView()
		  .environment(navigation)
		  .preferredColorScheme(.dark)
		  .onOpenURL { url in
			 handleWidgetClick(url: url)
		  }
	 }
	 .modelContainer(modelContainer)
  }
}


extension LabelBeApp{
  private func handleWidgetClick(url: URL) {
	 // Перевіряємо, чи це посилання на додавання запису
	 guard url.scheme == "labelbe", url.host == "add-entry" else { return }
	 
	 // Витягуємо ID лічильника з URL
	 guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
			 let queryItems = components.queryItems,
			 let idString = queryItems.first(where: { $0.name == "id" })?.value,
			 let uuid = UUID(uuidString: idString) else { return }
	 
	 
	 Task { @MainActor in
		if let counter = try? SwiftDataManager.shared.fetchById(uuid) {
		  SwiftDataManager.shared.addEntry(to: counter, value: 1)
		  
		  WidgetCenter.shared.reloadAllTimelines()
		}
	 }
  }
}
