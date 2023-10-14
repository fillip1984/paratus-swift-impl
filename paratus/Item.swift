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
    var percentageComplete: Int = 0

    init(label: String, timestamp: Date, percentageComplete: Int) {
        self.label = label
        self.timestamp = timestamp
        self.percentageComplete = percentageComplete
    }
}
