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

    @Bindable var item = Item(label: "", timestamp: .now, percentageComplete: 0)

    var body: some View {
        NavigationView {
            Form {
                TextField("Label", text: $item.label)
                TextField("Percent Complete", value: $item.percentageComplete, formatter: NumberFormatter())
            }.toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
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
