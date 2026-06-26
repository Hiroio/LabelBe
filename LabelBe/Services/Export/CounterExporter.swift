//
//  CounterExporter.swift
//  LabelBe
//

import Foundation

enum CounterExporter {
    static func makeCSV(for counters: [Counter]) -> String {
        var lines = ["Counter,Date,Change,Running Total"]

        for counter in counters.sorted(by: { $0.name < $1.name }) {
            var runningTotal = 0
            let sortedEntries = counter.entries.sorted { $0.timestamp < $1.timestamp }

            for entry in sortedEntries {
                runningTotal += entry.valueChange
                let date = entry.timestamp.formatted(date: .numeric, time: .standard)
                let name = counter.name.replacingOccurrences(of: ",", with: " ")
                lines.append("\(name),\(date),\(entry.valueChange),\(runningTotal)")
            }
        }

        return lines.joined(separator: "\n")
    }

    static func writeExportFile(for counters: [Counter]) -> URL? {
        let csv = makeCSV(for: counters)
        let fileName = "LabelBe-export-\(Int(Date.now.timeIntervalSince1970)).csv"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try csv.write(to: url, atomically: true, encoding: .utf8)
            return url
        } catch {
            return nil
        }
    }
}
