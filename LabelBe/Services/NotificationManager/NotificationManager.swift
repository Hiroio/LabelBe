//
//  NotificationManager.swift
//  MachoWin
//
//  Created by Vladuslav on 04.12.2025.
//

import UserNotifications
import Foundation
import Combine

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
  
    private init() {
      initialize()
    }

    func initialize() {
        Task {
          let isOn = UserDefaults.standard.bool(forKey: "profile.notificationsEnabled")
            
            guard isOn else {
                removeAll()
                return
            }

            let granted = await requestPermission()
            if granted {
                rescheduleAll()
            }
        }
    }

    private func requestPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        return await withCheckedContinuation { continuation in
            center.requestAuthorization(options: [.alert, .sound, .badge]) { ok, _ in
                continuation.resume(returning: ok)
            }
        }
    }

    func rescheduleAll() {
      let isOn = UserDefaults.standard.bool(forKey: "profile.notificationsEnabled")
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        guard isOn else { return }

        scheduleBatch(
            prefix: "morning",
            hour: 9,
            minute: 00,
            title: "Check your habits!",
            body: "Your next step to victory is ready. Open the app and crush today's habits!"
        )

        scheduleBatch(
            prefix: "evening",
            hour: 22,
            minute: 00,
            title: "Finish Strong",
            body: "The day is almost over. Make sure today's Habits tracked!"
        )
    }

    private func scheduleBatch(prefix: String, hour: Int, minute: Int, title: String, body: String) {
        let calendar = Calendar.current
        let now = Date()

        for offset in 0..<7 {
            guard let date = calendar.date(byAdding: .day, value: offset, to: now) else { continue }
            
            var comps = calendar.dateComponents([.year, .month, .day], from: date)
            comps.hour = hour
            comps.minute = minute
            
            if offset == 0, let targetDate = calendar.date(from: comps), targetDate <= now {
                continue
            }

            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            
            let id = "\(prefix)_\(format(date))"
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request)
        }
    }

    func removeAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    private func format(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        return f.string(from: date)
    }
}
