//
//  PreviewSupport.swift
//  LabelBe
//

import SwiftData

@MainActor
enum PreviewSupport {
    static func configureIfNeeded() {
        SwiftDataManager.shared.configure(modelContext: PreviewModelContainer.shared.mainContext)
    }
}
