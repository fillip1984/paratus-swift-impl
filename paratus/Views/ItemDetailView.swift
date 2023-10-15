//
//  ItemDetailView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @Bindable var item = Item(from: .now, to: .now)
    var formMode: FormMode

//    @State private var bgColor = Color(hex: item.color)
//    Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Label", text: $item.label)
//                    TextField("Percent Complete", value: $item.percentageComplete, formatter: NumberFormatter())
                    // Can't get this working, see: https://www.hackingwithswift.com/forums/swiftui/resolved-colors-and-swiftdata/22483
                    //                ColorPicker("Color", selection: $item.color)
                }

                Section("Schedule") {
                    Picker("Fill type", selection: $item.fillType) {
                        ForEach(FillType.allCases, id: \.self) { value in Text(value.rawValue).tag(value)
                        }
                    }

//                    if isDaysDriven(fillType: item.fillType) {
                    if item.fillType == .Days {
                        DatePicker("From", selection: $item.from, displayedComponents: .date)
                        TextField("Days", text: $item.days)
                            .numbersOnly($item.days)
                    }

                    if item.fillType == .ToDate {
                        DatePicker("To", selection: $item.to, displayedComponents: .date)
                    }
                }
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

                            if item.fillType == .Days {
                                item.to = Calendar.current.date(byAdding: .day, value: Int(item.days) ?? 0, to: item.from) ?? .now
                            }

                            if formMode == .Create {
                                if item.fillType == .ToDate {
                                    item.from = .now
                                }
                                context.insert(item)
                            }
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

// private func isDaysDriven(fillType: FillType) -> Bool {
//    return fillType == .Days
// }
//
// private func isDateDriven(fillType: FillType) -> Bool {
//    return fillType == .ToDate
// }

#Preview {
    ItemDetailView(formMode: .Create)
        .modelContainer(for: Item.self, inMemory: true)
}
