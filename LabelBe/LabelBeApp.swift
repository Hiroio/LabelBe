//
//  LabelBeApp.swift
//  LabelBe
//

import SwiftData
import SwiftUI

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
        }
        .modelContainer(modelContainer)
    }
}
