//
//  PlainIconButtonStyle.swift
//  LabelBe
//

import SwiftUI

struct PlainIconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
