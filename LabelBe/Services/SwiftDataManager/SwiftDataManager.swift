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

    func fetchActiveCounters() -> [Counter] {
        fetchCounters(archived: false)
    }

    func fetchArchivedCounters() -> [Counter] {
        fetchCounters(archived: true)
    }

    func fetchAllCounters() -> [Counter] {
        let descriptor = FetchDescriptor<Counter>(
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func fetchCounters() -> [Counter] {
        fetchActiveCounters()
    }

    func fetchById(_ id: UUID) throws -> Counter? {
        let descriptor = FetchDescriptor<Counter>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first
    }

    func addCounter(name: String, icon: String, tags: [String] = []) {
        let counter = Counter(name: name, icon: icon, tags: normalizedTags(from: tags))
        context.insert(counter)
        save()
    }

    func updateCounter(_ counter: Counter, name: String, icon: String, tags: [String]) {
        counter.name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        counter.icon = icon
        counter.tags = normalizedTags(from: tags)
        save()
    }

    func updateTags(for counter: Counter, tags: [String]) {
        counter.tags = normalizedTags(from: tags)
        save()
    }

    func setPinned(_ counter: Counter, isPinned: Bool) {
        counter.isPinned = isPinned
        save()
    }

    func archiveCounter(_ counter: Counter) {
        counter.isArchived = true
        counter.isPinned = false
        save()
    }

    func restoreCounter(_ counter: Counter) {
        counter.isArchived = false
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

    private func fetchCounters(archived: Bool) -> [Counter] {
        let descriptor = FetchDescriptor<Counter>(
            predicate: #Predicate { $0.isArchived == archived },
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )
        return (try? context.fetch(descriptor)) ?? []
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

    private func normalizedTags(from tags: [String]) -> [String] {
        var result: [String] = []
        for tag in tags {
            let trimmed = tag.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { continue }
            guard !result.contains(where: { $0.lowercased() == trimmed.lowercased() }) else { continue }
            result.append(trimmed)
        }
        return result
    }
}
