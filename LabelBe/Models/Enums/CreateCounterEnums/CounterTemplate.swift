//
//  CounterTemplate.swift
//  LabelBe
//

import Foundation

struct CounterTemplate: Identifiable, Equatable {
    let id: String
    let name: String
    let icon: String
    let tags: [String]
}

enum CounterTemplateCatalog {
    static let templates: [CounterTemplate] = [
        CounterTemplate(id: "water", name: "Water", icon: "drop.fill", tags: ["Health"]),
        CounterTemplate(id: "coffee", name: "Coffee", icon: "cup.and.saucer.fill", tags: ["Daily"]),
        CounterTemplate(id: "workout", name: "Workout", icon: "figure.run", tags: ["Fitness"]),
        CounterTemplate(id: "reading", name: "Reading", icon: "book.fill", tags: ["Growth"]),
        CounterTemplate(id: "meditation", name: "Meditation", icon: "leaf.fill", tags: ["Mind"]),
        CounterTemplate(id: "sleep", name: "Sleep", icon: "moon.fill", tags: ["Health"]),
    ]
}
