//
//  ItemCardView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftUI

struct ItemCardView: View {
    @Environment(\.modelContext) private var modelContext

    let item: Item
    @State var width = 0
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.blue)
                    .opacity(0.5)
                    .overlay(
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.blue)
                                .onAppear {
                                    withAnimation(.linear(duration: 0.6)) {
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

            // hides navigation arrow
            NavigationLink(destination: AddItemView(item: item)) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())
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
    print("Calcing width based on", percComplete, maxWidth)
    let w = (Double(percComplete) / 100) * maxWidth
    print("Width will be: ", w)
    return w
}

#Preview {
    ItemCardView(item: Item(label: "Test", timestamp: .now, percentageComplete: 0, color: "#fff")).modelContainer(for: Item.self, inMemory: true)
}
