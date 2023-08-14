//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Semen Kocherga on 2.08.2023.
//

import UIKit

struct TrackerCategory {
    let label: String
    let trackers: [Tracker]
    
    init(label: String, trackers: [Tracker]) {
        self.label = label
        self.trackers = trackers
    }
}
