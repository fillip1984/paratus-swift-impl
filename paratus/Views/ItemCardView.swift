//
//  ItemCardView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftUI

struct ItemCardView: View {
    @Environment(\.modelContext) private var modelContext

    var item: Item
    var editing: Bool

    @State var width: CGFloat = 0
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            RoundedRectangle(cornerRadius: 5)
                .fill(calcRemaining(item: item) >= 0 ? .blue : .red)
                .opacity(0.5)
                .overlay(
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(calcRemaining(item: item) >= 0 ? .blue : .red)
                            // TODO: this doesn't animate for some reason, even with a delay. Looks like it applies nearly as soon as the field is updated
//                            .onChange(of: item.percentageComplete) {
//                                withAnimation(.easeInOut(duration: 0.6)) {
//                                    width = item.percentageComplete
//                                }
//                            }
                            // this works
                            .onChange(of: editing) {
                                if editing == false {
                                    withAnimation(.easeInOut(duration: 0.6)) {
                                        width = calcWidth(item: item, maxWidth: geometry.size.width)
                                    }
                                }
                            }
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    width = calcWidth(item: item, maxWidth: geometry.size.width)
                                }
                            }
                            .frame(width: width)
                    }
                )
            HStack {
                Text(item.label)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 0))
                Spacer()
                if item.fillType != .None {
                    VStack {
                        Text(calcRemaining(item: item).description.replacing("-", with: "")).font(.subheadline)
                        Text(calcRemaining(item: item) > 0 ? "days remaining" : "days overdue")
                            .font(.footnote)
                    }
                    .foregroundColor(.white)
                    .padding(.trailing)
                }
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(
            RoundedRectangle(cornerRadius: 5)
                .background(.clear)
                .foregroundColor(.clear)
                .padding(
                    EdgeInsets(
                        top: 2,
                        leading: 0,
                        bottom: 2,
                        trailing: 0
                    )
                )
        )
        .swipeActions(allowsFullSwipe: false) {
            Button(role: .destructive) {
                withAnimation {
                    modelContext.delete(item)
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

func calcRemaining(item: Item) -> Int {
    let remaining = Calendar.current.dateComponents([.day], from: Date(), to: item.to).day ?? 0
    return remaining
}

func calcWidth(item: Item, maxWidth: Double) -> CGFloat {
    let total = Calendar.current.dateComponents([.day], from: item.from, to: item.to).day ?? 0
    let remaining = Calendar.current.dateComponents([.day], from: Date(), to: item.to).day ?? 0

    // guard against divide by zero
    if remaining == 0 {
        print("Item", item.label, "Has no due date")
        return 0
    }

    // guard against going over 100%
    if remaining < 0 {
        print("Item", item.label, "Is overdue")
        return maxWidth
    }

    let percentRemaining = (Double(remaining) / Double(total))
    print("Item", item.label, "total", total, "remaining", remaining, "percentRemaining", percentRemaining)

    return (1 - percentRemaining) * maxWidth
}

#Preview {
    ItemCardView(item: Item(label: "Test", from: .now, to: .now), editing: false)
        .modelContainer(for: Item.self, inMemory: true)
        .previewLayout(.sizeThatFits)
}
