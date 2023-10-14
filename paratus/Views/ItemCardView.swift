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

    @State var width = 0
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            RoundedRectangle(cornerRadius: 5)
                .fill(.blue)
                .opacity(0.5)
                .overlay(
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.blue)
                            // TODO: this doesn't animate for some reason, even with a delay. Looks like it applies nearly as soon as the field is updated
//                            .onChange(of: item.percentageComplete) {
//                                withAnimation(.easeInOut(duration: 0.6)) {
//                                    width = item.percentageComplete
//                                }
//                            }
                            // this works
                            .onChange(of: editing) {
                                if editing == false {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        width = item.percentageComplete
                                    }
                                }
                            }
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    width = item.percentageComplete
                                }
                            }
                            .frame(width: calcWidth(maxWidth: geometry.size.width, percComplete: width))
                    }
                )
            Text(item.label)
                .font(.title)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 20, leading: 5, bottom: 20, trailing: 0))
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

func calcWidth(maxWidth: Double, percComplete: Int) -> CGFloat {
    let w = (Double(percComplete) / 100) * maxWidth
    return w
}

#Preview {
    ItemCardView(item: Item(label: "Test", timestamp: .now, percentageComplete: 0, color: "#fff"), editing: false).modelContainer(for: Item.self, inMemory: true)
}
