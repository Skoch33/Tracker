//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Semen Kocherga on 2.08.2023.
//

import UIKit

struct TrackerCategory {
    let id: UUID
    let label: String
    
    init(id: UUID = UUID(), label: String) {
        self.id = id
        self.label = label
    }
}
