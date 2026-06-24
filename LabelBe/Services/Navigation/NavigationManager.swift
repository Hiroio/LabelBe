//
//  NavigationManager.swift
//  LabelBe
//

import Foundation

@Observable
final class NavigationManager {
    static let shared = NavigationManager()

    var mainScreens: MainScreensEnum = .main
    var counterScreen: SecondaryScreensEnum?

    private init() {}
}
