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
//    var remainingPercent: Int
    var fillType: FillType
    var from: Date?
    var to: Date?
    //    var color: String = "#fff"

    init(label: String = "",
//         remainingPercent: Int=0,
         fillType: FillType = .None,
         from: Date? = nil,
         to: Date? = nil)
    {
        self.label = label
//        self.remainingPercent = remainingPercent
        self.fillType = fillType
        self.from = from
        self.to = to
    }
}

enum FillType: String, CaseIterable, Codable {
    case None, Days, ToDate = "To Date"
}
