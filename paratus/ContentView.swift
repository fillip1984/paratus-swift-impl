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
            List(items) { item in
                ItemCardView(item: item).swipeActions(allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        withAnimation {
                            modelContext.delete(item)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                    Button {
                        itemToEdit = item
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.blue)
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 5)
                    .background(.clear)
                    .foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/)
            )
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
        }.sheet(item: $itemToEdit) {
            itemToEdit = nil
        } content: { item in AddItemView(item: item) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
