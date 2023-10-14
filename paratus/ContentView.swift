//
//  ContentView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    @State var showAddSheet = false
    @State var itemToEdit: Item?

    var body: some View {
        NavigationStack {
            List(items) {
                item in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.blue)
                            .opacity(0.5)
                        GeometryReader { geometry in
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.blue)
                                .frame(width: calcWidth(maxWidth: geometry.size.width, percComplete: item.percentageComplete))
                        }
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }.sheet(isPresented: $showAddSheet) {
            AddItemView()
        }
        // .sheet(item: $itemToEdit) {
        //            itemToEdit = nil
        //        } content: { item in AddItemView(item: item) }
    }
}

func calcWidth(maxWidth: Double, percComplete: Int) -> CGFloat {
    print("Calcing width based on", percComplete, maxWidth)
    let w = (Double(percComplete) / 100) * maxWidth
    print("Width will be: ", w)
    return w
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
