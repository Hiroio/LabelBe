//
//  SwiftDataManager.swift
//  LabelBe
//

import Foundation
import SwiftData

@Observable
final class SwiftDataManager {
    static let shared = SwiftDataManager()

    private var modelContext: ModelContext?

    private init() {}

    func configure(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchCounters() -> [Counter] {
        let descriptor = FetchDescriptor<Counter>(
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func addCounter(name: String, icon: String) {
        let counter = Counter(name: name, icon: icon)
        context.insert(counter)
        save()
    }

    func deleteCounter(_ counter: Counter) {
        context.delete(counter)
        save()
    }

    func addEntry(to counter: Counter, value: Int) {
        guard value == 1 || value == -1 else { return }

        let entry = CounterEntry(valueChange: value)
        entry.counter = counter
        counter.entries.append(entry)
        context.insert(entry)
        save()
    }

    private var context: ModelContext {
        guard let modelContext else {
            fatalError("SwiftDataManager is not configured. Call configure(modelContext:) from LabelBeApp.")
        }
        return modelContext
    }

    private func save() {
        do {
            try context.save()
        } catch {
            assertionFailure("SwiftData save failed: \(error.localizedDescription)")
        }
    }
}
