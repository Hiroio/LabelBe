//
//  InputFieldSurfaceModifier.swift
//  LabelBe
//

import SwiftUI

struct InputFieldSurfaceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(AppDesign.elevated, in: .rect(cornerRadius: AppDesign.inputCornerRadius))
    }
}
