//
//  Tracker.swift
//  Tracker
//
//  Created by Semen Kocherga on 2.08.2023.
//

import UIKit

struct Tracker: Identifiable {
    let id: UUID
    let label: String
    let emoji: String
    let color: UIColor
    let endedDaysCount: Int
    let schedule: [WeekDay]?

     init(id: UUID = UUID(), label: String, emoji: String, color: UIColor, endedDaysCount: Int, schedule: [WeekDay]?) {
         self.id = id
         self.label = label
         self.emoji = emoji
         self.color = color
         self.endedDaysCount = endedDaysCount
         self.schedule = schedule
     }
    
    init(tracker: Tracker) {
        self.id = tracker.id
        self.label = tracker.label
        self.emoji = tracker.emoji
        self.color = tracker.color
        self.endedDaysCount = tracker.endedDaysCount
        self.schedule = tracker.schedule
    }
    
    init(data: Data) {
        guard let emoji = data.emoji, let color = data.color else { fatalError() }
        
        self.id = UUID()
        self.label = data.label
        self.emoji = emoji
        self.color = color
        self.endedDaysCount = data.endedDaysCount
        self.schedule = data.schedule
    }
    
    var data: Data {
        Data(label: label, emoji: emoji, color: color, endedDaysCount: endedDaysCount, schedule: schedule)
    }
}

extension Tracker {
    struct Data {
        var label: String = ""
        var emoji: String? = nil
        var color: UIColor? = nil
        var endedDaysCount: Int = 0
        var schedule: [WeekDay]? = nil
    }
}

