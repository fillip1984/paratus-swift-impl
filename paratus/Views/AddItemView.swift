//
//  AddItemView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Bindable var item = Item(label: "", timestamp: .now, percentageComplete: 0, color: "#fff")

//    @State private var bgColor = Color(hex: item.color)
//    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var body: some View {
        NavigationView {
            Form {
                TextField("Label", text: $item.label)
                TextField("Percent Complete", value: $item.percentageComplete, formatter: NumberFormatter())
                // Can't get this working, see: https://www.hackingwithswift.com/forums/swiftui/resolved-colors-and-swiftdata/22483
//                ColorPicker("Color", selection: $item.color)
            }.toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
//                            let resolved = bgColor.resolve(in: EnvironmentValues())
//                            print("resolved ", resolved)
//                            item.color = resolved.description
                            save()
                            dismiss()
                        }
                    }
                }
            }
        }
    }

    private func save() {
        context.insert(item)
    }
}

#Preview {
    AddItemView()
        .modelContainer(for: Item.self, inMemory: true)
}
