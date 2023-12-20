//
//  Destination.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
//


import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    var time: Date
    var startDate:Date
    var endDate:Date
    //@Relationship(deleteRule: .cascade) var plans: [Plan]
    
    init(name: String = "", details: String = "", date: Date = .now, priority: Int = 2, time: Date = .now, startDate: Date = .now, endDate: Date = .now) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
        self.time = time
        self.startDate = startDate
        self.endDate = endDate
    }
}


@Model
class Plan {
    var name: String
    var emoji: String
    var time: Date
    var details: String
    
    init(name: String, emoji: String, time: Date, details: String) {
        self.name = name
        self.emoji = emoji
        self.time = time
        self.details = details
    
    }
}
