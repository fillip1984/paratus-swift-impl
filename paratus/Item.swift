//
//  Item.swift
//  paratus
//
//  Created by Phillip Williams on 10/14/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var label: String
    var timestamp: Date

    init(label: String, timestamp: Date) {
        self.label = label
        self.timestamp = timestamp
    }
}
