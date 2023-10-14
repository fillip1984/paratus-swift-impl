//
//  ItemCardView.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import SwiftUI

struct ItemCardView: View {
    let item: Item

    var body: some View {
        HStack {
            Text(item.label)
        }
        .background() {
            
        }
    }
}

#Preview {
    ItemCardView(item: Item(label: "Test", timestamp: .now))
}
