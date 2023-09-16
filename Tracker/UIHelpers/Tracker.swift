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
    let category: TrackerCategory
    let isPinned: Bool
    let endedDaysCount: Int
    let schedule: [WeekDay]?

    init(id: UUID = UUID(), label: String, emoji: String, color: UIColor, category: TrackerCategory, isPinned: Bool, endedDaysCount: Int, schedule: [WeekDay]?) {
         self.id = id
         self.label = label
         self.emoji = emoji
         self.color = color
         self.category = category
         self.endedDaysCount = endedDaysCount
         self.isPinned = isPinned
         self.schedule = schedule
     }
    
    init(tracker: Tracker) {
        self.id = tracker.id
        self.label = tracker.label
        self.emoji = tracker.emoji
        self.color = tracker.color
        self.category = tracker.category
        self.endedDaysCount = tracker.endedDaysCount
        self.isPinned = tracker.isPinned
        self.schedule = tracker.schedule
    }
    
    init(data: Data) {
        guard let emoji = data.emoji, let color = data.color, let category = data.category else { fatalError() }
        
        self.id = UUID()
        self.label = data.label
        self.emoji = emoji
        self.color = color
        self.category = category
        self.endedDaysCount = data.endedDaysCount
        self.isPinned = data.isPinned
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
        var category: TrackerCategory? = nil
        var endedDaysCount: Int = 0
        var isPinned: Bool = false
        var schedule: [WeekDay]? = nil
    }
}

