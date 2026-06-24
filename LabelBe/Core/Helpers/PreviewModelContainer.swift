//
//  PreviewModelContainer.swift
//  LabelBe
//

import Foundation
import SwiftData

@MainActor
enum PreviewModelContainer {
    static let shared: ModelContainer = {
        let schema = Schema([Counter.self, CounterEntry.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create preview ModelContainer: \(error.localizedDescription)")
        }
    }()
}
