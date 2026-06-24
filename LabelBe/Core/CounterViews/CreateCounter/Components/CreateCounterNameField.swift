//
//  CreateCounterNameField.swift
//  LabelBe
//

import SwiftUI

struct CreateCounterNameField: View {
    @Binding var name: String

    var body: some View {
        TextField("Name of Counter", text: $name)
            .font(.title3)
            .multilineTextAlignment(.center)
            .inputFieldSurface()
    }
}

#Preview {
    @Previewable @State var name = ""

    CreateCounterNameField(name: $name)
        .padding()
}
