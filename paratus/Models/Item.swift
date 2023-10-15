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
    var fillType: FillType
    var from: Date
    var to: Date
    var days: String

    init(label: String = "",
         fillType: FillType = .None,
         from: Date,
         to: Date,
         days: String = "")
    {
        self.label = label
        self.fillType = fillType
        self.from = from
        self.to = to
        self.days = days
    }
}

enum FillType: String, CaseIterable, Codable {
    case None, Days, ToDate = "To Date"
}
