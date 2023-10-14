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

    var widths = 0

    var body: some View {
        NavigationStack {
            List(items) {
                item in
                ItemCardView(item: item)
                    .onTapGesture {
                        itemToEdit = item
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
        .sheet(item: $itemToEdit) {
            itemToEdit = nil
        } content: { item in AddItemView(item: item) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: false)
}
